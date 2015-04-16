From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] log: honor log.merges= option
Date: Wed, 15 Apr 2015 23:07:35 -0700
Message-ID: <CAPc5daU+fk+d_tUiCmy0uwx7N5PYwLhqg6CmYGyaik_2VzQnMg@mail.gmail.com>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de> <1428938968-19013-2-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 08:08:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yicy1-0003d1-Ag
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 08:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbbDPGH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 02:07:57 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35050 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbbDPGH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 02:07:56 -0400
Received: by obbfy7 with SMTP id fy7so33499687obb.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=l/IoN1UFdtoJEB+WTh1q3u0i4bZmItaMfKtUW2KHGf8=;
        b=qDs6SkKoeH55CIhpponSQzrburYee2tm3i+A+7TxcgvpcpA2M21poHhowJXq6biRbp
         lyoNgU8R7mpNvtvvdCi33epHYRPRb5IRIjsyCWGoyZxu6WuKs5PI89aWPlsUb/Zechfn
         jq1tuC22SOtkeQdxxYgGVg2DIwoCvYHhBeju6b6yAxKaA4tOUZBncp638rjNkh/dFww6
         /qC+nVKz9c9OFIEqX0alka+cB/aLx1FeFsiC0MhGNUT1iv4rT1uzihQ+4iN4DQECn9BB
         Z7K7G8QwEmpwTmXTkfEbqPn8M6qnI0zueaXsqyLrzItvQfgUEcTPnOgMUWD4uEaMYWA1
         L9gg==
X-Received: by 10.202.53.11 with SMTP id c11mr19005356oia.60.1429164475558;
 Wed, 15 Apr 2015 23:07:55 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Wed, 15 Apr 2015 23:07:35 -0700 (PDT)
In-Reply-To: <1428938968-19013-2-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: W2E3YzgnJaOrYXz5vGOFArqlMyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267250>

On Mon, Apr 13, 2015 at 8:29 AM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> From: Junio C Hamano <gitster@pobox.com>

Let's not call this *my* change. The mechanism I did write, but I think the
most important part of the change is to decide which commands in the
log family should honor the configuration variable and which ones should
not. As I said in the beginning, I am not convinced that letting "git log" and
"git log" alone is the right choice. Make it "Helped-by" or something instead,
to make it clear that I helped the implementation but not the design.

> The config. variable is honored only by log. Other log family commands
> including show, shortlog and rev-list are affected only from the
> equivalent command line option (i.e. --merges=). Since these commands
> are somehow different representations of log command, we like to have
> the same behavior from them as we do from log itself. However, to not
> break the default output of them, we do not consider the the config.

That is a weak argument, isn't it? If we really wanted not to break the
default output, then "git log" should not honor the configuration variable,
either. And I do not agree with "we like to have the same behaviour" in
the first place.

My preference, as I already hinted in previous review rounds, is:

 - "log" and "whatchanged" are the same things and should behave the
   same way with respect to this configuration variable;

 - "rev-list" is plumbing and should never pay attention to a UI level
   configuration variable like this one;

 - "show" is given exact commit object(s) and is asked to show them;
   not showing what was explicitly asked to be shown only because
   the user has "do not show merges" configuration does not make
   much sense, so the configuration variable should be ignored;

 - The revision graph traversal done by "format-patch" and "cherry-pick"
   is primarily to determine the set of commits to process and of a
   different nature from the traversal done by "log", even though they
   share the same underlying code. It is not appropriate to pay attention
   to this configuration variable.

 - I am neutral as to "shortlog". As long as it pays attention to the
   new command line override, I think it is OK if it paid attention to
   the configuration variable, primarily because people most of the
   time use "shortlog --no-merges" with the current version of Git
   _anyway_.

Thanks.
