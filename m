From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at end of file
Date: Sat, 19 May 2007 23:58:54 +0200
Message-ID: <e5bfff550705191458o3fa1d1a0ndd916d1efafdd2a7@mail.gmail.com>
References: <464EF7D2.4030406@gmail.com>
	 <7vhcq8v97k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 23:59:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpWx5-0003r5-9V
	for gcvg-git@gmane.org; Sat, 19 May 2007 23:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbXESV64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbXESV64
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 17:58:56 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:25045 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327AbXESV6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 17:58:55 -0400
Received: by py-out-1112.google.com with SMTP id a29so1484578pyi
        for <git@vger.kernel.org>; Sat, 19 May 2007 14:58:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HiaV4vIILhgf2br4WjifcWOFGwFBUTHSp1z5YBEyvq29Vo3spPjw1WtqirMcSTi3Vh9WEwAogfUx6SwIj9fMpM4se2LWD0nDi8Bw3zDWfsdHnB2dhbN4hB5wzJ6R0fKC4cKnDKByqnTcqffz4ph9E9rW6cd+Wf8o/2rXzYovQNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EARW9raUU8Qhw7aDDQA4bClr0dNG8M6e0KD9dNZbrXROeaqjUK0MJyQ53jFNFhU1pJznjkUzUhpR/0UVXA3T3HuwNbU4TVg7poBYTcVJI6F46N1/JmryfkDsV21V4s0c3E66vGs1L1gWsreJFDcXOW5XBTthnQ5gTTjDL0NQt9w=
Received: by 10.114.39.16 with SMTP id m16mr1674988wam.1179611934210;
        Sat, 19 May 2007 14:58:54 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 19 May 2007 14:58:54 -0700 (PDT)
In-Reply-To: <7vhcq8v97k.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47778>

On 5/19/07, Junio C Hamano <junkio@cox.net> wrote:
> Marco Costalba <mcostalba@gmail.com> writes:
>
> > Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> > ---
> >   builtin-apply.c |    4 ++++
> >   1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index 0399743..f17f838 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -1738,6 +1738,10 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
> >               newsize--;
> >       }
> >
> > +     if (new_whitespace == strip_whitespace)
> > +             while (newsize > 1 && !strncmp(new + newsize - 2, "\n\n", 2))
> > +                     newsize--;
> > +
> >       oldlines = old;
> >       newlines = new;
> >       leading = frag->leading;
>
> I agree to what you are trying to do, but this patch is wrong.
> You are stripping trailing newlines that were NOT introduced by
> the patch, but happened to be present in the preimage (and in
> the context).
>
> Try it on this test vector:
>
> cat >AAA <<\EOF
> a
> b
> c
> d
>
>
> e
> f
> g
> h
> i
>
>
> j
> k
>
>
> EOF
> cat >P.diff <<\EOF
> diff --git a/AAA b/AAA
> index 59f6a9c..ffb28f5 100644
> --- a/AAA
> +++ b/AAA
> @@ -1,4 +1,4 @@
> -a
> +A
>  b
>  c
>  d
> @@ -6,12 +6,11 @@ d
>
>  e
>  f
> +
> +
>  g
>  h
> -i
> -
>
> -j
>  k
>
>
> EOF
>
>

What about this?

 builtin-apply.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 9e82757..113c71f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1746,10 +1746,15 @@ static int apply_one_fragment(struct
buffer_desc *desc, struct fragment *frag, i
 		newsize--;
 	}

-	if (new_whitespace == strip_whitespace)
-		while (newsize > 1 && !strncmp(new + newsize - 2, "\n\n", 2))
-			newsize--;
-
+	if (new_whitespace == strip_whitespace) {
+		int cnt1 =  1, cnt2 = 1;
+		while (newsize -  cnt1 > 1 && new[newsize - cnt1] == '\n')
+			cnt1++;
+		while (oldsize -  cnt2 > 1 && new[newsize - cnt2] == '\n')
+			cnt2++;
+		if (cnt1 > cnt2 && cnt1 > 2)
+			newsize -= cnt1 - cnt2;
+	}
 	oldlines = old;
 	newlines = new;
 	leading = frag->leading;
