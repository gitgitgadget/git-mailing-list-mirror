From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Fri, 28 Feb 2014 10:03:15 +0100
Message-ID: <CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:03:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJLp-0000H3-F4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaB1JDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:03:18 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:52747 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbaB1JDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:03:16 -0500
Received: by mail-vc0-f169.google.com with SMTP id hq11so439794vcb.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zuIYFPlIEC12lCx+uLCdRxiMyNBY1UitWXKliy/8ECQ=;
        b=iDZvNNTDMsfypZfOMZYncrAbVFZZlrCQRuKwa9Xj+e3TUo/lVFyOnCu25laaxgv5/x
         QzuPPtlZ8qiDMK9LggLKe7WqKenc5O3frvJgLT/WWzEY46IQGPtaGA56OIQwEtrde2wp
         zK3/Cmjhe3DMYDHoGZ6KzaqshPCThF/lJTKT8cK7pSwCayRezPQldEJ1paUF0cqyuYyL
         /EJ3dKX3CXLZVPHSb5dNIuPqJwbkhfE56CLmeC67AcUDjIgNSIPGl6uSJqJmYd22Z0kO
         XPJQ6BPYtFIAXMMwWO2/SPD17gRmXdqbS6Ub+7ccOUlcsQp9rqGt9nQQ3d81vnQ7eh8A
         82SA==
X-Received: by 10.221.66.73 with SMTP id xp9mr1437369vcb.27.1393578195644;
 Fri, 28 Feb 2014 01:03:15 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Fri, 28 Feb 2014 01:03:15 -0800 (PST)
In-Reply-To: <530F1F11.7060403@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242910>

On Thu, Feb 27, 2014 at 12:18 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I don't understand the benefit of adding a new command "mark" rather
> than continuing to use "good", "bad", plus new commands "unfixed" and
> "fixed".  Does this solve any problems?
>

As Matthieu Moy remarked in a previous email, the main reason is
extensibility: I prefer having a single command to assign new
descriptive labels instead of having to patch git-bisect.sh to create
new labels like fixed, unfixed, fast, slow...

> What happens if the user mixes, say, "good" and "fixed" in a single
> bisect session?
>

I don't think that's an issue. If the user uses the label "fixed"
instead of "bad" she will have a hard time remembering to use it every
time she needs it, and maybe the output of "git bisect" will look very
confusing, but what can git do? This is a semantic user input error,
not a syntax one.

> I think it would be more convenient if "git bisect" would autodetect
> whether the history went from "good" to "bad" or vice versa.  The
> algorithm could be:
>
> 1. Wait until the user has marked one commit "bad" and one commit "good".
>
> 2. If a "good" commit is an ancestor of a "bad" one, then "git bisect"
> should announce "I will now look for the first bad commit".  If
> reversed, then announce "I will now look for the first good commit".  If
> neither commit is an ancestor of the other, then explain the situation
> and ask the user to run "git bisect find-first-bad" or "git bisect
> find-first-good" or to mark another commit "bad" or "good".
>
> 3. If the user marks another commit, go back to step 2, also doing a
> consistency check to make sure that all of the ancestry relationships go
> in a consistent direction.
>
> 4. After the direction is clear, the old bisect algorithm can be used
> (though taking account of the direction).  Obviously a lot of the output
> would have to be adjusted, as would the way that a bisect is visualized.
>
> I can't think of any fundamental problems with a scheme like this, and I
> think it would be easier to use than the unfixed/fixed scheme.  But that
> is only my opinion; other opinions are undoubtedly available :-)
>

I like this idea! It also looks fun to implement. A minor difference
is that I'd rather die with an error on point 2) if there's no
ancestorship relation between the two commits; if the user is asking
for such a thing then she has a fundamental misconception of the state
of her repository.

> By the way, although "git bisect fixed/unfixed" would be a very useful
> improvement, and has gone unimplemented for a lamentably long time, my
> personal feeling is that it has too meat in it to constitute a GSoC
> project by itself.

Oh! Then in fact, as Christian Couder said, this project shouldn't be
marked as "easy".

(Sorry for sending this email twice! I thought I had sent it to the
list as well.)

On Thu, Feb 27, 2014 at 12:18 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 02/26/2014 09:28 AM, Jacopo Notarstefano wrote:
>> my name is Jacopo, a student developer from Italy, and I'm interested
>> in applying to this years' Google Summer of Code. I set my eyes on the
>> project called "git-bisect improvements", in particular the subtask
>> about swapping the "good" and "bad" labels when looking for a
>> bug-fixing release.
>
> Hello and welcome!
>
>> I have a very simple proposal for that: add a new "mark" subcommand.
>> Here is an example of how it should work:
>>
>> 1) A developer wants to find in which commit a past regression was
>> fixed. She start bisecting as usual with "git bisect start".
>> 2) The current HEAD has the bugfix, so she marks it as fixed with "git
>> bisect mark fixed".
>> 3) She knows that HEAD~100 had the regression, so she marks it as
>> unfixed with "git bisect mark unfixed".
>> 4) Now that git knows what the two labels are, it starts bisecting as usual.
>>
>> For compatibility with already written scripts, "git bisect good" and
>> "git bisect bad" will alias to "git bisect mark good" and "git bisect
>> mark bad" respectively.
>>
>> Does this make sense? Did I overlook some details?
>
> I don't understand the benefit of adding a new command "mark" rather
> than continuing to use "good", "bad", plus new commands "unfixed" and
> "fixed".  Does this solve any problems?
>
> What happens if the user mixes, say, "good" and "fixed" in a single
> bisect session?
>
> I think it would be more convenient if "git bisect" would autodetect
> whether the history went from "good" to "bad" or vice versa.  The
> algorithm could be:
>
> 1. Wait until the user has marked one commit "bad" and one commit "good".
>
> 2. If a "good" commit is an ancestor of a "bad" one, then "git bisect"
> should announce "I will now look for the first bad commit".  If
> reversed, then announce "I will now look for the first good commit".  If
> neither commit is an ancestor of the other, then explain the situation
> and ask the user to run "git bisect find-first-bad" or "git bisect
> find-first-good" or to mark another commit "bad" or "good".
>
> 3. If the user marks another commit, go back to step 2, also doing a
> consistency check to make sure that all of the ancestry relationships go
> in a consistent direction.
>
> 4. After the direction is clear, the old bisect algorithm can be used
> (though taking account of the direction).  Obviously a lot of the output
> would have to be adjusted, as would the way that a bisect is visualized.
>
> I can't think of any fundamental problems with a scheme like this, and I
> think it would be easier to use than the unfixed/fixed scheme.  But that
> is only my opinion; other opinions are undoubtedly available :-)
>
>> There were already several proposals on this topic, among which those
>> listed at https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_bisect_fix.2Funfixed.
>> I'm interested in contacting the prospective mentor, Christian Couder,
>> to go over these. What's the proper way to ask for an introduction? I
>> tried asking on IRC, but had no success.
>
> Just CC Christian on your emails to the mailing list, like I've done
> with this email.  As a rule of thumb all communications should go to the
> mailing list *plus* any people who are likely to be personally
> interested in the topic (e.g., because they have participated in the
> thread).
>
> By the way, although "git bisect fixed/unfixed" would be a very useful
> improvement, and has gone unimplemented for a lamentably long time, my
> personal feeling is that it has too meat in it to constitute a GSoC
> project by itself.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
