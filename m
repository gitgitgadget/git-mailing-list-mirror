From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Wishlist] could git tell which password it is asking when
 asking a password.
Date: Fri, 01 Jul 2011 10:00:27 -0700
Message-ID: <7v62nmos0k.fsf@alter.siamese.dyndns.org>
References: <877h82nlua.dlv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Fri Jul 01 19:00:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qch53-0008MM-2A
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 19:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab1GARAb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 13:00:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab1GARAa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2011 13:00:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CAA94B55;
	Fri,  1 Jul 2011 13:02:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1vHcRYOR/AN1
	jmKFrUnwGaG1L9U=; b=iIHx5xF/kIYcwz70khDIWapY/IKPGjN/zEBiv34tPjSl
	1EsMvDzV/3yp4zMg2rxY3oZHWLrhKXYxbdGa8/FRhLIW6ipMy7cLYDLKyIbGlGMl
	X8P7GcDDSiRFbYWRwI074ygSLUaYDRlDdnEM6N/VmSJCGxPkLFEryN35KeiOvKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pj/WKY
	YLSHh1mq4ftT4e5ux4vm8rzmGsGFeI6P+zwOkk623aU1uwzpl3lXulzDvzvneFPB
	UDDIsqz1OedTw09vmo+2nwKpljETIdo5b1CNizd9D23PntUPrkY9QCPbyzfxPwUX
	P0gxaC6iPkbkx3usX+fXBSIlUCeH3DVnMPHCQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34B7F4B54;
	Fri,  1 Jul 2011 13:02:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75E004B53; Fri,  1 Jul 2011
 13:02:43 -0400 (EDT)
In-Reply-To: <877h82nlua.dlv@debian.org> (=?utf-8?Q?=22R=C3=A9mi?= Vanicat"'s
 message of "Fri, 01 Jul 2011 15:59:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFB9E4A6-A403-11E0-A4CB-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176524>

R=C3=A9mi Vanicat <vanicat@debian.org> writes:

> When git is asking for a password (for example for pushing over https=
)
> it call the $GIT_ASKPASS script with only "Password: " as a an argume=
nt,
> so when one have several remote, it might not know which one is askin=
g
> the password.=20

On the C side, git_getpass() is the function to touch. It has only thre=
e
callers.

In init_curl_http_auth() in http.c, we know "user_name" but we do not g=
ive
it as a hint when coming up with a prompt.  A possible update to the
git_getpass() API would be to make the call look like this:

diff --git a/http.c b/http.c
index a1ea3db..ee3e821 100644
--- a/http.c
+++ b/http.c
@@ -214,7 +214,7 @@ static void init_curl_http_auth(CURL *result)
 	if (user_name) {
 		struct strbuf up =3D STRBUF_INIT;
 		if (!user_pass)
-			user_pass =3D xstrdup(git_getpass("Password: "));
+			user_pass =3D git_getpass(_("Password for %s: "), user_name);
 		strbuf_addf(&up, "%s:%s", user_name, user_pass);
 		curl_easy_setopt(result, CURLOPT_USERPWD,
 				 strbuf_detach(&up, NULL));

The points are

 (1) to show identity for which the password is being asked for;
 (2) to give a fresh and stable memory, making it unnecessary to
     xstrdup() while at it.

The same thing for the call in has_cert_password(), which may want to u=
se ssl_cert
as the identifier.

There is an abuse of git_getpass() in http_request() to ask for the
username. It inherits the "noecho"-ness of git_getpass() which gives a
bad user experience. We _may_ want to give another parameter to git_get=
pass()
to specify if we want noecho.

The other call is from imap-send.c that knows srvc->user and srvc->host
and formulates the prompt including the identity. So an alternative rou=
te
may be to keep git_getpass() as-is, and update the init_curl_http_auth(=
)
callsite to include the username (but imap-send assumes that user and h=
ost
are relatively short without verifying that assumption, and should not =
be
used as a model of good existing code).

> It would be interesting also to plug some sort of password-safe unto
> git, or some "git-agent".=20

I am not particularly interested in seeing git specific agent. Somethin=
g
that can be called as an external process that talks with existing
practices (gpg agent and friends) would be nice.
