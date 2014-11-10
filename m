From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Mon, 10 Nov 2014 09:19:00 -0800
Message-ID: <xmqqfvdr9dob.fsf@gitster.dls.corp.google.com>
References: <53FD0CD1.7030801@raz.or.at> <545F6586.109@web.de>
	<545F8079.7010806@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Mon Nov 10 18:19:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnscU-0002Ad-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 18:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbaKJRTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2014 12:19:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752785AbaKJRTJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 12:19:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 553DE1BD5E;
	Mon, 10 Nov 2014 12:19:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b+9UfLIaaIeJ
	tpC9OxeL0QTwkjM=; b=t+4Qy1l4mH1LEKX4GqXkiE9SUDHNmuJqEI6tSKYtgu2q
	LWdmGuCwrgAOHLElvO9RTV3JL6VUNV22R/Va4eUTflX9O1l4EVrgLrSX7DHvSpHQ
	4+XqfXdAP0hgEPSpIiYeK7zBNoEzhx9EHhz7PAZE+ThM0RMVPxA6Ghu+rRyQfug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cpsOYI
	TIFvYrncoy+WRv8/E0mSQLKlGr41WA23IyuVBsu2ve2Wf9SYroW/AdAyu++nxTCe
	3gJLIMEl+rxIj1HhqrolLIUKlyGgIC9Mlj0XjKQxiDC/e4t6QmqHoc1rHuXS8NAg
	gD28ZQDKlzqdZGNaCYLksMvgPrRPUj8V5D+iI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ACE71BD5D;
	Mon, 10 Nov 2014 12:19:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8E5D1BD5C;
	Mon, 10 Nov 2014 12:19:01 -0500 (EST)
In-Reply-To: <545F8079.7010806@raz.or.at> (Bernhard Reiter's message of "Sun,
	09 Nov 2014 15:55:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA0E3E9E-68FD-11E4-BD24-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bernhard Reiter <ockham@raz.or.at> writes:

> Am 2014-11-09 um 14:00 schrieb Torsten B=C3=B6gershausen:
>> On 2014-08-27 00.40, Bernhard Reiter wrote:
>>> Use libcurl's high-level API functions to implement git-imap-send
>>> instead of the previous low-level OpenSSL-based functions.
>>>
>> This doesn't seem to fully work under Debian 7:
>> /home/tb/projects/git/git.pu/imap-send.c:1546: undefined reference
>> to `curl_append_msgs_to_imap'
>
> Thx for the notice. I forgot to guard that with an #ifdef.
>
> The new patch below includes that, and the fix sent by Ramsay;
> hopefully the squashed/edited commit message is fine.

Queued with a small fix-ups, including

 - line-fold a couple of overlong lines;

 - avoid decl-after-stmt of "int prev_len";

 - reduce the scope of "struct struct auth" down to only the block
   it is used;

 - the footer of the log message now reads "helped-by ramsay", your
   sign-off and then mine.

Thanks.

diff --git a/imap-send.c b/imap-send.c
index 08271d9..4dfe4c2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1349,7 +1349,8 @@ static void git_imap_config(void)
 	git_config_get_string("imap.authmethod", &server.auth_method);
 }
=20
-static int append_msgs_to_imap(struct imap_server_conf *server, struct=
 strbuf* all_msgs, int total)
+static int append_msgs_to_imap(struct imap_server_conf *server,
+			       struct strbuf* all_msgs, int total)
 {
 	struct strbuf msg =3D STRBUF_INIT;
 	struct imap_store *ctx =3D NULL;
@@ -1391,7 +1392,6 @@ static CURL *setup_curl(struct imap_server_conf *=
srvc)
 {
 	CURL *curl;
 	struct strbuf path =3D STRBUF_INIT;
-	struct strbuf auth =3D STRBUF_INIT;
=20
 	if (curl_global_init(CURL_GLOBAL_ALL) !=3D CURLE_OK)
 		die("curl_global_init failed");
@@ -1414,11 +1414,12 @@ static CURL *setup_curl(struct imap_server_conf=
 *srvc)
 	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
=20
 	if (server.auth_method) {
+		struct strbuf auth =3D STRBUF_INIT;
 		strbuf_addstr(&auth, "AUTH=3D");
 		strbuf_addstr(&auth, server.auth_method);
 		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+		strbuf_release(&auth);
 	}
-	strbuf_release(&auth);
=20
 	if (server.use_ssl)
 		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_ALL);
@@ -1436,7 +1437,8 @@ static CURL *setup_curl(struct imap_server_conf *=
srvc)
 	return curl;
 }
=20
-static int curl_append_msgs_to_imap(struct imap_server_conf *server, s=
truct strbuf* all_msgs, int total) {
+static int curl_append_msgs_to_imap(struct imap_server_conf *server,
+				    struct strbuf* all_msgs, int total) {
 	int ofs =3D 0;
 	int n =3D 0;
 	struct buffer msgbuf =3D { STRBUF_INIT, 0 };
@@ -1449,17 +1451,19 @@ static int curl_append_msgs_to_imap(struct imap=
_server_conf *server, struct strb
 	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s"=
 : "");
 	while (1) {
 		unsigned percent =3D n * 100 / total;
+		int prev_len;
=20
 		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
=20
-		int prev_len =3D msgbuf.buf.len;
+		prev_len =3D msgbuf.buf.len;
 		if (!split_msg(all_msgs, &msgbuf.buf, &ofs))
 			break;
 		if (server->use_html)
 			wrap_in_html(&msgbuf.buf);
 		lf_to_crlf(&msgbuf.buf);
=20
-		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE, (curl_off_t)(msgbuf=
=2Ebuf.len-prev_len));
+		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE,
+				 (curl_off_t)(msgbuf.buf.len-prev_len));
=20
 		res =3D curl_easy_perform(curl);
=20
