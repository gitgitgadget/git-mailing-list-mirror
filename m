From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/8] revert: Improve error handling by cascading errors
 upwards
Date: Thu, 19 May 2011 10:39:39 +0000
Message-ID: <20110519103938.GA2949@domU-12-31-39-06-A8-0A.compute-1.internal>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-2-git-send-email-artagnon@gmail.com>
 <20110511095949.GA2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 12:39:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN0dy-0000ua-0S
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 12:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab1ESKjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 06:39:45 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34106 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab1ESKjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 06:39:44 -0400
Received: by qwk3 with SMTP id 3so1280755qwk.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EPYQRHcN5kUdhfvZHlWB4KhBs/QhhObxrWTgXS2UW40=;
        b=bZ9wevvWLTUa76jj5ryuppkVqhAjBseRLxk86dZ529w96qwMbI7mUY0ncNAqwXSGSS
         y4oYkfXXtqZ53YkdLzWRWqNHDcC+VRLspiBT3ZGeJV9Rm5BXmYGSd1w0Z85UMFW/Q9GS
         zv7Uj8T09A2gbnIbfDRyilby9BkiyvCVhsPRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GjRU0xy50Sf0TZphD34tiLdNiMfxLUmwNgS7eyPUCO8b2sl4N3v2R6X2Sa68OHAuuz
         hzOEXz32fGsaYeRWUpz8mX4oiguO7L8vFBtBREGn52Q81O/tm7OE7A3ByW5mKOfPTfrZ
         V6kl5JY7IFc6DMNYe9oDlTtGcynbD9faCPBq8=
Received: by 10.224.31.80 with SMTP id x16mr2349779qac.73.1305801583282;
        Thu, 19 May 2011 03:39:43 -0700 (PDT)
Received: from domU-12-31-39-06-A8-0A.compute-1.internal (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id m9sm1532504qcu.27.2011.05.19.03.39.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2011 03:39:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110511095949.GA2676@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173947>

Hi,

I'm preparing a large series dedicated to solving error-handling
issues before getting to the sequencer series.  I plan to post some
quick-and-dirty diffs of various things and ask for feedback.

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > @@ -418,19 +434,19 @@ static int do_pick_commit(void)
> >             struct commit_list *p;
> >
> >             if (!mainline)
> > -                   die(_("Commit %s is a merge but no -m option wa=
s given."),
> > -                       sha1_to_hex(commit->object.sha1));
> > +                   return error(_("Commit %s is a merge but no -m =
option was given."),
> > +                           sha1_to_hex(commit->object.sha1));
>
> This is not a conflict but an error in usage.  Stepping back for a
> second, what is the best way to handle that?  The aforementioned
> hypothetical caller considering "try an alternate strategy" would mak=
e
> a wrong move, so we need to use a return value that would dissuade it=
=2E
>
> I=E2=80=99m not sure what the most appropriate thing to do is.  Maybe
>
>       /*
>        * Positive numbers are exit status from conflicts; negative
>        * numbers are other errors.
>        */
>       enum pick_commit_error {
>               PICK_COMMIT_USAGE_ERROR =3D -1
>       };
>
> but it=E2=80=99s hard to think clearly about it since it seems too
> hypothetical to me.  If all callers are going to exit, then
>
>       error(...);
>       return 129;
>
> will work, but in that case why not exit for them?

=46or this part, I think the correct way to handle the usage error is t=
o
print a message like this:

   usage: cherry-pick: Commit b8bf32 is a merge but no -m option was gi=
ven.

And exit with status 129. Is this acceptable?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

@@ -418,20 +424,20 @@ static int do_pick_commit(void)
               struct commit_list *p;

               if (!mainline)
-                       die(_("Commit %s is a merge but no -m option wa=
s given."),
-                           sha1_to_hex(commit->object.sha1));
+                       usage(_("%s: Commit %s is a merge but no -m opt=
ion was given."),
+                               me, sha1_to_hex(commit->object.sha1));

               for (cnt =3D 1, p =3D commit->parents;
                    cnt !=3D mainline && p;
                    cnt++)
                       p =3D p->next;
               if (cnt !=3D mainline || !p)
-                       die(_("Commit %s does not have parent %d"),
-                           sha1_to_hex(commit->object.sha1), mainline)=
;
+                       usage(_("%s: Commit %s does not have parent %d"=
),
+                               me, sha1_to_hex(commit->object.sha1), m=
ainline);
               parent =3D p->item;
-       } else if (0 < mainline)
-               die(_("Mainline was specified but commit %s is not a me=
rge."),
-                   sha1_to_hex(commit->object.sha1));
+       } else if (mainline > 0)
+               usage(_("%s: Mainline was specified but commit %s is no=
t a merge."),
+                       me, sha1_to_hex(commit->object.sha1));
