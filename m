From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-rebase -i prunes commits with empty commit-message
Date: Thu, 11 Mar 2010 14:14:13 +0100
Message-ID: <40aa078e1003110514n3bdf12ecq6b3a77e0312e742d@mail.gmail.com>
References: <40aa078e1003081207u20046916yda5a62d44ce7a401@mail.gmail.com>
	 <4B979AEF.5010201@alum.mit.edu>
	 <40aa078e1003100534j189eef5kd60855f80e9dd626@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Michal Vitecek <fuf@mageo.cz>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 11 14:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiDa-0004T0-7c
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330Ab0CKNOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 08:14:17 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46208 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322Ab0CKNOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:14:15 -0500
Received: by wwb39 with SMTP id 39so4172wwb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vrW2S4B2S1oRgIb1tAEYolNY8tPRLK5q4d9It/mNTB0=;
        b=iHoApgf5VXv4Eu1+3nVHfG984iAS7xuj+z+kNl6KA1YumcbUoZ6OmLstVOqiTja6H6
         a7sfglLs/hXcT/yMRpxJ0W+s+Kt7K0YVrwmGurrpgvkqWaKRAP1ZanLfnxqFlz2/0EUc
         KQWBqwUULI/x3Qx0YLGL31E+NvUkAzchgoRnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=OOKE1XXocvepWGKwx/8FCCz/BuYpcKrpLcdFam6uq113MS0m2OkC3SV3Zutr+TFzJT
         FBs6F8CP3EXVdVqx5O/fiEFrPWo9rjEYKFNDu2/uX7MVCEHsr+z5jNop9sijb2TF+osu
         HH7Hk+F8w1UEOYoxAEPBbj0lhrvh6mybKMUuk=
Received: by 10.216.88.207 with SMTP id a57mr230882wef.200.1268313253484; Thu, 
	11 Mar 2010 05:14:13 -0800 (PST)
In-Reply-To: <40aa078e1003100534j189eef5kd60855f80e9dd626@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141961>

On Wed, Mar 10, 2010 at 2:34 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
>
> But to be honest, it seems to me like in this precise instance it's
> probably better to just fix git-rebase--interactive.sh. There's no
> good reason for it to barf on the commits -- especially since
> noon-interactive rebase handles them just fine. Unless someone screams
> out loud, I might take a stab at it when I get time.
>

I think I've found the culprit: git-rev-list doesn't append a
newline-separator after commits with empty messages.
git-rebase--interactive.sh basically eats git rev-list's output line
by line, prepending "pick ".

This seems to have been introduced in 55246aa "Don't use "<unknown>"
for placeholders and suppress printing of empty user formats." by
Michal Vitecek. It seems he intended to fix a rev-list with
--pretty=format:"" or something like that, but I can't get custom
formats to work at all with rev-list, even if the documentation says
it should.

Anyway, the following patch seems to fix the problem for me, but I'm
not very confident that it doesn't break whatever Michal was trying to
address.

--->8---
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 5679170..b13e1ba 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -134,10 +134,8 @@ static void show_commit(struct commit *commit, void *data)
                                if (graph_show_remainder(revs->graph))
                                        putchar('\n');
                        }
-               } else {
-                       if (buf.len)
-                               printf("%s%c", buf.buf, info->hdr_termination);
-               }
+               } else
+                       printf("%s%c", buf.buf, info->hdr_termination);
                strbuf_release(&buf);
        } else {
                if (graph_show_remainder(revs->graph))
--->8---

-- 
Erik "kusma" Faye-Lund
