From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add builtin dump command, to query a repository using a pipe.
Date: Sat, 26 Jan 2008 01:46:28 -0800
Message-ID: <7vr6g4zzpn.fsf@gitster.siamese.dyndns.org>
References: <fnduk3$d0c$1@ger.gmane.org>
	<7vve5hyln3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 10:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIhd4-0002hs-Ti
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 10:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYAZJqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 04:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbYAZJqo
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 04:46:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYAZJqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 04:46:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BC733206;
	Sat, 26 Jan 2008 04:46:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B45FB3205;
	Sat, 26 Jan 2008 04:46:37 -0500 (EST)
In-Reply-To: <7vve5hyln3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 26 Jan 2008 01:35:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71769>

Another thing.

As currently written, the "dump" server is strictly one-request, 
one-response interface.

I can easily see the command set to be extended to allow
transfer of richer set of data (e.g. whether a ref is a symref
and if so where it points at, querying config variables).  Also,
if you want to write a repository browser using this "dump"
server, you would first throw a commit at it, learn its parents
and its tree, and then you suddenly have _many_ objects that you
can simultaneously ask about without doing one-request,
one-response exchange.

So it might make sense to base this not on line-per-line message
format using strbuf_getline() interface, but base it instead on
packet_read_line()/packet_write() interface, and explicitly mark
the end of a batch of request with packet_flush().  That would
allow the "protocol" stream, which would matter even more when
you run this over the network, perhaps via git-daemon and/or
from connect.c


  
