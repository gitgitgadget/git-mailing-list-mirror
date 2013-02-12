From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: A good Git technique for referring back to original files
Date: Tue, 12 Feb 2013 23:13:07 +0000
Message-ID: <CALeLG_nFgApPT1B+6sPy7P+jrtjB4KQOBpPO9bEd0rsWKqWi8A@mail.gmail.com>
References: <loom.20130212T085620-989@post.gmane.org>
	<vpq1ucl9agt.fsf@grenoble-inp.fr>
	<loom.20130212T110458-119@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: MikeW <mw_phil@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:13:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5P2c-0006wq-3I
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab3BLXNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:13:09 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52409 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3BLXNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:13:08 -0500
Received: by mail-oa0-f46.google.com with SMTP id k1so688684oag.19
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 15:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=VYUNzB5RnQz/IhgnSYEOOxmznmu7tu2zz/+pTYu3YdE=;
        b=LdEh4fj0Alwa7uTHr0VRd6aV78AW5QppQ9/xqEtcHHF3pwJJF37CfwHKBMnbQ9mA9L
         2lbLuOBV0UtWRTzqfJdsOfwcyKmmHgEb7kDNxq0MTUIKH/967S/TNgF1Eo6/J9MIJS9s
         6jSUOgmY/6fqZZINFL1+/2e65GzNl2uCNIcmpvLHIuQktoL+LZlSsqVTHlLSDleHoLLk
         MZmZmWRWmsGLBIRmuuaBb8KiJ96TOtpGZM6eVO0Fn7uES7jkB8NukbpAXmHI+zIibcZo
         xKHInboT5A3c85YgPTe0BuSnq3WCsR/4FzqCJRYM1vdRJisucFYOUd70m2bF9oJ1qFbK
         K07g==
X-Received: by 10.182.51.98 with SMTP id j2mr9647040obo.77.1360710787782; Tue,
 12 Feb 2013 15:13:07 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Tue, 12 Feb 2013 15:13:07 -0800 (PST)
X-Originating-IP: [2.102.85.14]
In-Reply-To: <loom.20130212T110458-119@post.gmane.org>
X-Gm-Message-State: ALoCoQlyTgk1GdIZXozSiej+Rp0UWJ6xRaOg6NNRwgSaxhzzTnlrHxzad9WAjuUXuk+3a8F40Ppa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216219>

Hi Mike,

I think git-cvsimport and git-subtree could help you here.

Roughly:

# Create a git version of each SDK_subproj
git cvsimport -r upstream -d $CVSREPO1 $CVSMODULE1 -C SDK_subproj1
git cvsimport -r upstream -d $CVSREPO2 $CVSMODULE2 -C SDK_subproj2

# Create your Working_SDK
git init Working_SDK
cd Working_SDK

# Import the SDK_subprojN repos
git subtree add --prefix=subproj1 ../SDK_subproj1 upstream/master
git subtree add --prefix=subproj2 ../SDK_subproj2 upstream/master

# Edit and commit your files
# N.B. when committing don't commit to more than one subproj in a single commit

# Update from the upstream CVS as needed
git cvsimport -r upstream -d $CVSREPO1 $CVSMODULE1 -C ../SDK_subproj1
git subtree pull --prefix=subproj1 ../SDK_subproj1 upstream/master
git cvsimport -r upstream -d $CVSREPO2 $CVSMODULE2 -C ../SDK_subproj2
git subtree pull --prefix=subproj2 ../SDK_subproj2 upstream/master

# Push your changes back to SDK_subproj repos into a branch other than master
git subtree push --prefix=subproj1 ../SDK_subproj1 new-branch
git subtree push --prefix=subproj1 ../SDK_subproj2 new-branch

# Prepare patches to apply to a real CVS copy or submit upstream
(cd ../SDK_subproj1 && git format-patch upstream/master..new-branch)
(cd ../SDK_subproj2 && git format-patch upstream/master..new-branch)

Hope that helps.

--
Paul

On Tue, Feb 12, 2013 at 10:19 AM, MikeW <mw_phil@yahoo.co.uk> wrote:
> Matthieu Moy <Matthieu.Moy <at> grenoble-inp.fr> writes:
>
>>
>> MikeW <mw_phil <at> yahoo.co.uk> writes:
>>
>> > Since git is so good at tracking file content, I wondered whether
> there was any
>> > technique using git that would simplify the back-referencing task.
>>
>> I'm not sure I understand the question, but if you want to add meta-data
>> to Git commits (e.g. "this Git commit is revision 42 in CVS repository
>> foo"), then have a look at git-notes. It won't give you directly
>> "reference to other VCS", but at least can be used as a storage
>> mechanism to store these references.
>>
> Thanks for the reply.
>
> In my work environment both the SDK and the original files are available
> (in an enclosing directory).
>
> --SDK_content
>   |
>   SDK_subproj1-- ...
>   |            |
>   |            content
>   |
>   SDK_subproj2- ...
>   |            |
>   |            content
>   |
>   SDK_subprojN- ...
>   |            |
>   |            content
>   |
>   Working_SDK ... (under git, baseline generated from subproj1..N)
>                |
>                content derived from subproj1..N
>
>
> What I had in mind was something I could run over, say, SDK_content
> (alternatively, from within Working_SDK, referring back to SDK_content)
> which would note the changed files in Working_SDK and locate the
> original files in SDK_subproj1..N letting me merge the changes back.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Paul [W] Campbell
