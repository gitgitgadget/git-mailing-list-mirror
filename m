X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 9 Nov 2006 01:04:31 +0100
Message-ID: <200611090104.32247.jnareb@gmail.com>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 9 Nov 2006 00:04:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NBV4hWsN366fVIw1Fh1uyJyDm0o2K5KaPxohHcCy2EUOlyY3xfDK9otfRVZTdxA32IV0oU1PUBQD1JNg+/RySq2jM0HdrF58+Hl3cmlvC/Lb6wq4/R6SSVtYjq17NNcdZIZkOKM9Titng397KW7R5DlER+V/t6dI10iXoZ4IeNk=
User-Agent: KMail/1.9.3
In-Reply-To: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31168>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhxOV-0004Wj-7R for gcvg-git@gmane.org; Thu, 09 Nov
 2006 01:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161771AbWKIADo convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 19:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161772AbWKIADo
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 19:03:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:58515 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161771AbWKIADo
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 19:03:44 -0500
Received: by ug-out-1314.google.com with SMTP id m3so67593ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 16:03:42 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr355156ugj.1163030622615; Wed, 08 Nov
 2006 16:03:42 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id p32sm34902ugc.2006.11.08.16.03.42; Wed, 08 Nov
 2006 16:03:42 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> This reuses the quot_cec to protect blob and text diff output
> from leaking control characters.
>=20
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> =A0* requesting extra sets of eyeballs.

This changes the "blob" and "text diff" output somewhat, as earlier it=20
used Control key Sequence (CS) representation for some non-whitespace=20
control characters (not "\t' not '\n'), namely replacing form feed (FF)=
=20
('\f', '\014') with ^L and escape (ESC) ('\e', '\033') with ^[.

And (what is not said in the commit message) it additionally esc_html=20
some title elements (the subroutine should be I think named esc_attr).

The problems are:
1. First, esc_path should _not_ use subroutine which does it's own=20
contol characters escaping. That was also a mistake I made in my patch.
Perhaps we should have some quot_html or to_html subroutine which does=20
_only_ to_utf8 (decode from Encode module), escapeHTML and optionally=20
s/ /&nbsp;/g conversion.

2. In my opinion CS is better than CEC for quoting/escaping control=20
characters in the "bulk" output, namely "blob" output and "text=20
diff" (patchset body) output. CEC is better for pathnames (which must=20
fit in one line), and perhaps other one-liners; perhaps not. I'm not=20
sure what quoting to choose for esc_attr, but there we could use even=20
--no-control-chars quoting (replacing any control character by '?');=20
but perhaps in some cases like git_print_page_path subroutine CEC is=20
better.

BTW. what had happened with to_qtext post?
--=20
Jakub Narebski
