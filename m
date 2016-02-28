From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v3 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Sun, 28 Feb 2016 08:20:19 +0100
Message-ID: <56D29FB3.3030707@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de> <56D28092.9090209@moritzneeb.de>
 <CAPig+cSv=7zixz_BK=f0MhQnTTB-agB5=4aSrFE5vAJtOgbuGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 08:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZveb-0007NT-Kx
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 08:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbcB1HUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 02:20:23 -0500
Received: from moritzneeb.de ([78.47.1.106]:37151 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcB1HUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 02:20:22 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id CE4631C02F;
	Sun, 28 Feb 2016 08:20:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456644020;
	bh=Ek0ldhO8gmmhqwyddEY+bFO+JWsO95PzAd1h6GB1NBE=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=pDWGagJpMzLqpFNPlzBIQG4qGMDrzjwN3WazF9RQtDIhDCXE8cFidkuRCEW09aEUK
	 8HZoUbhbJNi5AKf0AO/6bmqSwNkOXQk4u+jhhwyvL01hH2nNlg9Tfi2SUpVt4S0ZmI
	 22TTQQri86uPhbgI0RN+MurpAnuLZdLi1N4uV8f4=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAPig+cSv=7zixz_BK=f0MhQnTTB-agB5=4aSrFE5vAJtOgbuGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287755>

On 02/28/2016 07:30 AM, Eric Sunshine wrote:
> On Sun, Feb 28, 2016 at 12:07 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
>> This series deals with strbuf_getline_lf() in certain codepaths:
>> Those, where the input that is read, is/was trimmed before doing anything that
>> could possibly expect a CR character. Those places can be assumed to be "text"
>> input, where a CR never would be a meaningful control character.
>> [...]
>>
>> Changes since v2:
>>
>> * Line splitting in notes_copy_from_stdin() is changed to string_list_split as
>>   suggested by Eric Sunshine.
>> * The behavior change in interactive cleaning from patch v2 is undone.
>> * Some of the previous patches were broken because of some unexpected
>>   whitespace. This should be fixed now.
> 
> In the future, as an aid to reviewers, please include an interdiff
> since the previous version, as well a link to the previous round[1].
> It's also very helpful to say which patches have changed (and which
> have not).
> 
> Thanks.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=286865
> 

Maybe not too late for other reviewers, here comes the interdiff (this assumes the non-broken version 2):

diff --git a/builtin/clean.c b/builtin/clean.c
index 18b6056..5b17a31 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -570,7 +570,9 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 			       clean_get_color(CLEAN_COLOR_RESET));
 		}
 
-		if (strbuf_getline(&choice, stdin) == EOF) {
+		if (strbuf_getline(&choice, stdin) != EOF) {
+			strbuf_trim(&choice);
+		} else {
 			eof = 1;
 			break;
 		}
@@ -650,7 +652,9 @@ static int filter_by_patterns_cmd(void)
 		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
 		clean_print_color(CLEAN_COLOR_RESET);
-		if (strbuf_getline(&confirm, stdin) == EOF)
+		if (strbuf_getline(&confirm, stdin) != EOF)
+			strbuf_trim(&confirm);
+		else
 			putchar('\n');
 
 		/* quit filter_by_pattern mode if press ENTER or Ctrl-D */
@@ -746,7 +750,9 @@ static int ask_each_cmd(void)
 			qname = quote_path_relative(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
-			if (strbuf_getline(&confirm, stdin) == EOF) {
+			if (strbuf_getline(&confirm, stdin) != EOF) {
+				strbuf_trim(&confirm);
+			} else {
 				putchar('\n');
 				eof = 1;
 			}
diff --git a/builtin/notes.c b/builtin/notes.c
index 706ec11..660c0b7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -292,17 +292,17 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		unsigned char from_obj[20], to_obj[20];
-		struct strbuf **split;
+		struct string_list split = STRING_LIST_INIT_DUP;
 		int err;
 
-		split = strbuf_split(&buf, ' ');
-		if (!split[0] || !split[1])
+		string_list_split(&split, buf.buf, ' ', -1);
+
+		if (split.nr != 2)
 			die(_("Malformed input line: '%s'."), buf.buf);
-		strbuf_rtrim(split[0]);
-		if (get_sha1(split[0]->buf, from_obj))
-			die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
-		if (get_sha1(split[1]->buf, to_obj))
-			die(_("Failed to resolve '%s' as a valid ref."), split[1]->buf);
+		if (get_sha1(split.items[0].string, from_obj))
+			die(_("Failed to resolve '%s' as a valid ref."), split.items[0].string);
+		if (get_sha1(split.items[1].string, to_obj))
+			die(_("Failed to resolve '%s' as a valid ref."), split.items[1].string);
 
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, from_obj, to_obj);
@@ -312,11 +312,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 		if (err) {
 			error(_("Failed to copy notes from '%s' to '%s'"),
-			      split[0]->buf, split[1]->buf);
+			      split.items[0].string, split.items[1].string);
 			ret = 1;
 		}
 
-		strbuf_list_free(split);
+		string_list_clear(&split, 0);
 	}
 
 	if (!rewrite_cmd) {
