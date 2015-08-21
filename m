From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] format_config: simplify buffer handling
Date: Fri, 21 Aug 2015 10:42:44 -0700
Message-ID: <xmqqvbc85yi3.fsf@gitster.dls.corp.google.com>
References: <20150820144504.GA22935@sigill.intra.peff.net>
	<20150820144733.GB11913@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 19:42:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSqL4-0003Cu-R6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 19:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbHURmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 13:42:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33659 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbHURmp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 13:42:45 -0400
Received: by pacgz8 with SMTP id gz8so1240522pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y3a/Ri6rXePf8E2b5JcNdhmVES87mH+c6kksR/7l02U=;
        b=Jyav2e8Yra4qJ2d5kS1lj4TjK4ETfrF53LKaQqwJSGOgb4H4RY0hsluZddZF+Hsdds
         5CRitAyWBgVzUa3HDCWXgao0bcqMIpVZAlN/ZGL5cEJ0TvWY+hkaGGL/s29rD9wlBnAM
         21fVLIqBo8bFkb1C8BWSapchQEmT8ahLLWDZ9JxcX9roWBnDl0BqxZoG4n+e3kxijreg
         OODVjKBArK+s7iNzFp0yxrtTHKZdEPQZtVeM1U0N1yMLvNFThlX5LiJukThweLLTpiaS
         riDaAYlKn+ffr/zej+eR7pJqfJcvna+uo2XTjJlyYzQzQtM6kuULOF9kKvofraFPWaDO
         g3Ig==
X-Received: by 10.68.69.107 with SMTP id d11mr19151326pbu.45.1440178965268;
        Fri, 21 Aug 2015 10:42:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id oq3sm8493036pdb.75.2015.08.21.10.42.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 10:42:44 -0700 (PDT)
In-Reply-To: <20150820144733.GB11913@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Aug 2015 10:47:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276316>

Jeff King <peff@peff.net> writes:

> When formatting a config value into a strbuf, we may end
> up stringifying it into a fixed-size buffer using sprintf,
> and then copying that buffer into the strbuf. We can
> eliminate the middle-man (and drop some calls to sprintf!)
> by writing directly to the strbuf.
>
> The reason it was written this way in the first place is
> that we need to know before writing the value whether to
> insert a delimiter. Instead of delaying the write of the
> value, we speculatively write the delimiter, and roll it
> back in the single case that cares.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I admit the rollback is a little gross. The other option would be adding
> the delimiter in each of the conditional branches, which is also kind of
> nasty.

I actually am fine with this rollback.  The "variable alone stands
for true" is not something a user can produce from the command line
very easily, so having to rollback is a rare event anyway.

I wonder if we can do this instead

	if (!omit_values) {
-		if (show_keys)
+		if (show_keys && value_)
			strbuf_addch(buf, key_delim);

though.  That would eliminate the need for rolling back.

I briefly wondered how such a change would interact with

        if (types == TYPE_INT)
                strbuf_addf(buf, "%"PRId64,
                            git_config_int64(key_, value_ ? value_ : ""));

that immediately follows it, but this "turn NULL into an empty
string" may be bogus in the first place, in the sense that
git_config_int64() should complain about a NULL value_ the same way
as it would complain about an empty string---both them are not an
integer.  And indeed:

 - git_parse_int64() that is called from git_config_int64() is
   prepared to take both "" and NULL and return failure with EINVAL;

 - die_bad_number() that is eventually called when parsing fails by
   git_config_int64() is prepared to take NULL and turns it to an
   empty string.

So perhaps we could do this squashed in?

 builtin/config.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 71acc44..593b1ae 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -111,12 +111,12 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
-		if (show_keys)
+		if (show_keys && value_)
 			strbuf_addch(buf, key_delim);
 
 		if (types == TYPE_INT)
 			strbuf_addf(buf, "%"PRId64,
-				    git_config_int64(key_, value_ ? value_ : ""));
+				    git_config_int64(key_, value_));
 		else if (types == TYPE_BOOL)
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
@@ -136,9 +136,8 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
-			/* Just show the key name; back out delimiter */
-			if (show_keys)
-				strbuf_setlen(buf, buf->len - 1);
+			/* Just show the key name */
+			;
 		}
 	}
 	strbuf_addch(buf, term);
