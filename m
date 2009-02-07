From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Sat, 07 Feb 2009 13:34:10 -0800
Message-ID: <7vskmque25.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
 <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com>
 <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0902050049240.10279@pacific.mpi-cbg.de>
 <94a0d4530902071309l7c34945ana2af31e41707fa0c@mail.gmail.com>
 <alpine.DEB.1.00.0902072214410.10279@pacific.mpi-cbg.de>
 <94a0d4530902071315o78b2db58n481fbc6e956b5b64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:35:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVuq1-0004uF-Qe
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbZBGVeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbZBGVeT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:34:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbZBGVeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:34:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AE8F997F27;
	Sat,  7 Feb 2009 16:34:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 48E5397F24; Sat,
  7 Feb 2009 16:34:11 -0500 (EST)
In-Reply-To: <94a0d4530902071315o78b2db58n481fbc6e956b5b64@mail.gmail.com>
 (Felipe Contreras's message of "Sat, 7 Feb 2009 23:15:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12318044-F55F-11DD-A9D1-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108883>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>> I think it should, how expensive would it be to call
>>> git_config(git_default_config, NULL) when it has been loaded already?
>>
>> We would not need the complete git_default_config(), would we?
>
> Nope, just core.editor. But I don't know how to load only that.

The most expensive part is to actually open and parse the files into
tokens, not strcmp/prefixcmp the parsed tokens and flipping internal bits
and storing value in const char * variables.

But you need to be careful about correctness issues.  I do not want
launch_editor() to run git_config().  The caller, other than the caller
you happen to be interested in this thread, may already have read the
config and overrode some of the bits with what was given from the command
line.  Calling git_config() overwrite the bits and will break these
callers.

I think the right thing to do is to call git_config() immediately before
you call launch_editor() in your patch.
