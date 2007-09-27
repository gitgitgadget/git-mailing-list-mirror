From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Re: [PATCH] quiltimport: Skip non-existent patches
Date: Thu, 27 Sep 2007 14:45:37 -0700
Message-ID: <91705d080709271445k62f2867am99114eb0e98fc408@mail.gmail.com>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
	 <1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
	 <loom.20070927T203413-499@post.gmane.org>
	 <7v1wcju93a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1B4-00014t-Ht
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 23:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbXI0Vpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 17:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755464AbXI0Vpj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 17:45:39 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:37287 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138AbXI0Vpi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 17:45:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2426290rvb
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SVPVpkzdS7SAQqgxAxZgP6dcmZiIvb4Wf5opCyuvByk=;
        b=lhqbP4TUe3TxxlCtsjTAuNrKDrA8zC/M4k1BYv86pL8gLCE+lZdCLiluPZtOIPui/rWBiGIeAsCuWzgoXHD2ZjJwM98oY/w5/Y5DL4ow1NQTsH+o4EYexvAHMHvoFNTg531N5M2Z+zqi0GvVAyvRWqXdOH8qz6KUWNOOGa2IykY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oTYft2iHNOSPk5TBTB/7SLJsYKLEQcWMnQQMxg4FRa2Omi7kqxXJxW4XX22h/Ae2hTixKY9YI3RcSs2BMPMzyHqFzsbFWAAOF38Bykv8lze5mibIY4QnZbaizVMU0yYalTXOyO6tgQETbGTq86T4/0kU+QsirloIPkGJoEVtMEk=
Received: by 10.140.132.8 with SMTP id f8mr1209217rvd.1190929537923;
        Thu, 27 Sep 2007 14:45:37 -0700 (PDT)
Received: by 10.143.8.3 with HTTP; Thu, 27 Sep 2007 14:45:37 -0700 (PDT)
In-Reply-To: <7v1wcju93a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59339>

On 9/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> Dan Nicholson <dbn.lists@gmail.com> writes:
>
> > Dan Nicholson <dbn.lists <at> gmail.com> writes:
> >>
> >> When quiltimport encounters a non-existent patch in the series file,
> >> just skip to the next patch. This matches the behavior of quilt.
> >>
> >> Signed-off-by: Dan Nicholson <dbn.lists <at> gmail.com>
> >> ---
> >>  git-quiltimport.sh |    4 ++++
> >>  1 files changed, 4 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> >> index 74a54d5..880c81d 100755
> >> --- a/git-quiltimport.sh
> >> +++ b/git-quiltimport.sh
> >> @@ -71,6 +71,10 @@ commit=$(git rev-parse HEAD)
> >>
> >>  mkdir $tmp_dir || exit 2
> >>  for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
> >> +    if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
> >> +            echo "$patch_name doesn't exist. Skipping."
> >> +            continue
> >> +    fi
> >>      echo $patch_name
> >>      git mailinfo "$tmp_msg" "$tmp_patch" \
> >>              <"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
> >
> >
> > I forgot to mention the rationale for this patch vs. what Junio sent. The issue
> > with Junio's patch is that the failure will occur before $tmp_patch is created
> > because the script tries to feed git-mailinfo a non-existent patch
> > ($patch_name). You'll only get past the mailinfo if $patch_name exists.
> >
> > The marker setting may still be useful in this context, though, to suppress the
> > "doesn't exist" message.
>
> Thanks.  I did not know what "marker" meant by the original
> context and assumed there is a file referred to by the series
> file but there is no patch in that file.  Instead it seems that
> a series file can contain something that is _not_ a file and
> that is called the marker, right?

I'm actually not a quilt user, but I tested out that patch on a repo
with a series containing a non-existent patch. I'm not sure what's
actually in Geerd's "marker", but I believe it's just random text.

When you run the command `quilt series', it just lists what's in the
series file (minus any comments). And when you run `quilt push' with a
non-existent patch, it says "Patch foo.patch does not exist; applied
empty patch"

So, I think the consistent thing to do is what's in my patch: just
skip the patch with a message to the user. Maybe the message can be
tailored to match quilt's output. Actually, it would be best to also
skip on empty files since quiltimport will bomb in that case as well.

--
Dan
