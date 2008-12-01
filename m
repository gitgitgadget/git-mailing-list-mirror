From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 01 Dec 2008 11:54:44 -0800
Message-ID: <7voczvr7qz.fsf@gitster.siamese.dyndns.org>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
 <1228140775-29212-3-git-send-email-gitster@pobox.com>
 <1228140775-29212-4-git-send-email-gitster@pobox.com>
 <1228140775-29212-5-git-send-email-gitster@pobox.com>
 <1228140775-29212-6-git-send-email-gitster@pobox.com>
 <20081201162011.GI23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 20:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7EtE-0006Oe-Ta
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 20:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYLATzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 14:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYLATzq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 14:55:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYLATzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 14:55:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ABF9D828E1;
	Mon,  1 Dec 2008 14:55:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EFD1D828C5; Mon,
  1 Dec 2008 14:54:46 -0500 (EST)
In-Reply-To: <20081201162011.GI23984@spearce.org> (Shawn O. Pearce's message
 of "Mon, 1 Dec 2008 08:20:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09AE5774-BFE2-11DD-B656-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102079>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Maybe we put on the first capability line a flag that lets the
> client know we have symref data in the advertised list, and then
> instead of sticking only HEAD into that first ref we put the names
> of the symrefs after the ref they point to.
>
> So we might see something like:
>
>   xxxx......................... refs/heads/boo\0with-symref\0
>   xxxx......................... refs/heads/master\0HEAD\0
>   xxxx......................... refs/remotes/origin/HEAD\0refs/remotes/origin/master\0
>
> etc.  Its probably harder to produce the output for, but it permits
> advertising all of the symrefs on the remote side, which may be good
> for --mirror, among other uses.  It also should make it easier to put
> multiple symrefs down pointing at the same real ref, they could just
> be a space delimited list stored after the ref name, and if its the
> first ref in the stream, after the other capability advertisement.

It certainly is possible, and I think the arrangement v2 code makes
already keeps that option to talk about symrefs other than HEAD open.  If
you want to send all the symref information, you would show something
like:

    xxxx... HEAD\0<caps>\0refs/heads/master\n
    xxxx... refs/heads/master\n
    xxxx... refs/remotes/origin/HEAD\0<caps>\0refs/remotes/origin/master\n
    xxxx... refs/remotes/origin/master\n

But in this round I am not interested in giving any "random symref"
information but "HEAD", so I omitted it from the code.  

Notice that you need to repeat the capabilities list on each and every
line that describes a symbolic ref for that to work (and you do not need
"with-symref"), though.  See what ll. 80-84 in connect.c does.

	if (len != name_len + 41) {
		free(server_capabilities);
		server_capabilities = xstrdup(name + name_len + 1);
	}

Historical accident mandates that the first hidden piece of information on
each and all of these lines _must_ be the capabilities list.
