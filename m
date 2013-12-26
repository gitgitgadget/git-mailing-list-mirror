From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Thu, 26 Dec 2013 11:24:32 -0800
Message-ID: <xmqqlhz7ct5b.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
	<1387789361-29036-1-git-send-email-pclouds@gmail.com>
	<20131226172542.GS20443@google.com>
	<xmqqtxdvcuj0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, tfnico@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 20:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwGXw-0002M0-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 20:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab3LZTYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 14:24:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab3LZTYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 14:24:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF3695AA32;
	Thu, 26 Dec 2013 14:24:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AmBgrXOk3Onj9Vb+8NgnIIX69ls=; b=l/pMYC
	TNsDBExwXift0YgVhxRkvHptadMpH/OuyO5mwdmWXI1GgoHtsH59p+66eJuswwPE
	q535IE+RCWT6heV2l38LDaIEW80DKkbkluxRoUEOrXIVthE0NxqL2TdjKOZoN6Pw
	wWEmfWFBmhaP0eVCILggaEAWIZoP+DqSVBUos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m0DddIu1djvC9/A/R1CXzD4C+vP6k3oj
	CO8v1yET3uEZiR0h0FM7L7ai3mETNrwyOLE5k1FvoY5HWVm/JYPaRVCHbVTHJNcd
	v43rCDLbvuxw0P0KkdQyuyw5Czx/LlXiq9ttvCU9zmJRzvQbnjqkk40LTrbKBxUb
	dhu7rR1rCzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E25255AA2F;
	Thu, 26 Dec 2013 14:24:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54A2B5AA2E;
	Thu, 26 Dec 2013 14:24:35 -0500 (EST)
In-Reply-To: <xmqqtxdvcuj0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Dec 2013 10:54:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5AAFE52C-6E63-11E3-B618-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239707>

Junio C Hamano <gitster@pobox.com> writes:

> Regarding "git add --refresh" (no other arguments), it would say
> "Nothing specified, nothing added.", and that is unrelated to the
> breakage reported and fixed in this thread, I think.  It is the same
> message "git add" (no other arguments) gives, which I think is a
> mistake.  "git add --refresh" is like "git add -u" in that the
> affected paths are determined by the index, and running these
> commands while your index is still empty can just be a silent no-op.

Something like this...

 builtin/add.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d7e3e44..84e8a3e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -483,8 +483,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (implicit_dot ? ADD_CACHE_IMPLICIT_DOT : 0);
 
 	if (require_pathspec && argc == 0) {
-		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		if (!refresh_only) {
+			fprintf(stderr, _("Nothing specified, nothing added.\n"));
+			fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		}
 		return 0;
 	}
 
