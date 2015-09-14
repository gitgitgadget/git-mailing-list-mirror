From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] git-p4: improve path encoding verbose output
Date: Mon, 14 Sep 2015 11:40:33 -0700
Message-ID: <xmqqbnd4x2se.fsf@gitster.mtv.corp.google.com>
References: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com>
	<1442250640-93838-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 14 20:40:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbYgD-0003eK-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 20:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbbINSkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 14:40:37 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32971 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbINSkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 14:40:35 -0400
Received: by pacex6 with SMTP id ex6so151318020pac.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LgfavFtGeb5oyNMCe7tu4RgO9dUr2iJPc5Kr1RVbWY8=;
        b=M54dy9HcZxFgPyGmdkfhZt5HVJH0MNbzbe0dtyANzAhoUjbsFVAlAr6qFN1153GaIN
         9zeR/ck9PekvWEnVh3AGz9Nf0yli0xtiwn40uAHlz5lqQNLu496CrNtJP4PKJnh2+Ul7
         JYRhSjxneWVDyiJb20320EqatowYf9HGzcgTZXleZniZq/MZT49TIJrYKQJerWDtXpVF
         cyv5TrEQvCYhmhHUQmXyGqBMP7NPUu7NMlRL5KrCibwnKBLmmixyjDb3/VBhUL5M9P1Y
         fLEPnKDzOzYzti3C693X0KueWMtBWmmGH24mSLHgo0h7iOoFi7n4me3bQGAa/4gcD0aK
         OquA==
X-Received: by 10.68.197.97 with SMTP id it1mr37633402pbc.4.1442256034776;
        Mon, 14 Sep 2015 11:40:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id qe3sm17508512pbc.73.2015.09.14.11.40.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 11:40:34 -0700 (PDT)
In-Reply-To: <1442250640-93838-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 14 Sep 2015 19:10:40
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277859>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> If a path with non-ASCII characters is detected then print always the
> encoding and the encoded string in verbose mode.

Earlier if the user tells us that s/he knows what she is doing
by setting the configuration, we just followed the instruction
without complaining or notifying.  The differences in this version
are

 (1) if the path is in ASCII, the configuration is not even
     consulted, and we didn't do any path munging.

 (2) for a non-ASCII path, even if the user tells us that s/he knows
     what she is doing, we notify what we did under "--verbose"
     mode.

I think (1) is a definite improvement, but it is not immediately
obvious why (2) is an improvement.  It is clearly a good thing to
let the user know when we munged the path without being told, but
when the configuration is given, it can be argued both ways.  It may
be a good thing to reassure that the configuration is kicking in, or
it may be a needless noise to tell the user that we did what we were
told to do.

In any case, I suspectq that the call to decode-encode to munge
relPath is indented one level too deep in this patch.  You would
want to use the configured value if exists and utf8 if there is no
configuration, but in either case you would want to munge relPath
when it does not decode as ASCII, no?

> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  git-p4.py | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index d45cf2b..da25d3f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2220,16 +2220,15 @@ class P4Sync(Command, P4UserMap):
>              text = regexp.sub(r'$\1$', text)
>              contents = [ text ]
>  
> -        if gitConfig("git-p4.pathEncoding"):
> -            relPath = relPath.decode(gitConfig("git-p4.pathEncoding")).encode('utf8', 'replace')
> -        elif self.verbose:
> -            try:
> -                relPath.decode('ascii')
> -            except:
> -                print (
> -                    "Path with Non-ASCII characters detected and no path encoding defined. "
> -                    "Please check the encoding: %s" % relPath
> -                )
> +        try:
> +            relPath.decode('ascii')
> +        except:
> +            encoding = 'utf8'
> +            if gitConfig('git-p4.pathEncoding'):
> +                encoding = gitConfig('git-p4.pathEncoding')
> +                relPath = relPath.decode(encoding).encode('utf8', 'replace')
> +            if self.verbose:
> +                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
>  
>          self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
