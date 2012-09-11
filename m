From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 13:18:29 +0200
Message-ID: <CABPQNSZznFvjCLR7A7sACf9NcESek7DmOeJcSSHFY1cGHwD2Jg@mail.gmail.com>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
 <CABPQNSYv1hd8RFHfcQ1XTB94nu6xo+tjj4CvWur29152z2dk6A@mail.gmail.com> <vpq392og8fg.fsf@bauges.imag.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@entel.upc.edu>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 11 13:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBOUx-0005YP-5j
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 13:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758755Ab2IKLTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 07:19:11 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54366 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317Ab2IKLTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 07:19:10 -0400
Received: by vcbfy27 with SMTP id fy27so412769vcb.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 04:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RVBK6F2fpEcbIO7AAmSl5bqYSJkw6XEZtD/pJDY1khw=;
        b=gfrzz6Pt9EneFnUJ1nKQ/dJREz0XMD8h+abyCbB1XRDSw3r0l1vH85ll9I9iZKo/GP
         XMCajWiiw0rNclKMiVBjFxDtdAnv5iFd7rgxLRsGfheb4gh+mfo0m9p181qo6oRorIP7
         K2wI1WQvkWhbJ69rOiNhyX9tbYTz53imdKFqgiG3PN1igJd8hejFGKWE1ovOZ9pFQ1br
         r4uDVvPlDwXSoQ/xl7dmWrewaI8/iGoDWuSHDw6tSd70wEu3ZhTcytL+Esk5wkFPyShw
         hlJe2tm0CrWi/dEnO2v/i1a9mAzggREmoJvCMMfCwxSyXafVUd2Vil6sc/BgO4oClejp
         I6kw==
Received: by 10.52.67.175 with SMTP id o15mr7633304vdt.71.1347362349845; Tue,
 11 Sep 2012 04:19:09 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Tue, 11 Sep 2012 04:18:29 -0700 (PDT)
In-Reply-To: <vpq392og8fg.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205219>

On Tue, Sep 11, 2012 at 12:28 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> I have stumbled upon a similar issue on Windows (which also has a
>> case-preserving filesystem), and I seem to remember the solution being
>> something to do with packed refs.
>
> Packed-refs use a format like this:
>
> $ tail -3 .git/packed-refs
> e94214ce4b8acefce06d4ea37b76ac0de11ecb2d refs/tags/v1.7.9.5
> bf68fe0313c833fa62755176f6e24988ef7cf80f refs/tags/v1.7.9.6
> 3996bb24c84013ec9ce9fa0980ce61f9ef97be4d refs/tags/v1.7.9.7
>
> so the ref name is stored within the file, not as the file name. So,
> yes, packing refs (done by "git pack-refs", called by "git gc" among
> other things) should solve case-insensitive issues.
>
> However, creating or updating refs after a pack will still create
> unpacked refs, so this solves the issue only if one of the colliding
> branches is not updated anymore.
>

Of course. In my case, the colliding refs weren't fetched from the
same source IIRC.

>> Perhaps we could change Git to detect name-collisions and
>> automatically pack the refs in such cases?
>
> That's a bit harder than it seems, as the idea is to avoid re-writting
> the packed-refs file for each ref update. Repacking after each colliding
> ref update could be costly in terms of performance.

Yes, but being costly in terms of performance is IMO a lot better than
corrupting refs, which is what we currently do.

And it should really only be costly in the case where there's actually
such a cost, on a file system where such a collision can happen.
