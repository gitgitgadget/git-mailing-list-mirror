From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: fix selection regression introduced in a8ca786991
Date: Mon, 9 Jan 2012 10:28:19 +0100
Message-ID: <CAKPyHN0xRD7qYyLYaCB9u7mhCZYFObuTdJGHq-rRST-cEhTtXA@mail.gmail.com>
References: <14628854a651ab0202e3f82be9b245331cf9029a.1325965254.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Jan 09 10:28:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkBWk-0007rt-Sy
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 10:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab2AIJ2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 04:28:22 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:56580 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2AIJ2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 04:28:20 -0500
Received: by werm1 with SMTP id m1so2443462wer.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 01:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B7ZHznNnYR0ls8b92BOW+BdLrQ8XoDykCEOLfGDkIRA=;
        b=RtCzq+ghzNkRk0y05RRD+5srrOGFS33PxuSp7LQLTUqLVF7IBTOHdhnbRtmcWtWp+R
         O3zwPrgi2gcR8Xp57hY4dTd3iUFMy60v/nSf+bBIhmGanGX9U0jNHmb/5u3xiU6LFx1v
         gUwr35YWoV8yve7BPiGuwc9Cu6jLZBoFRmzdA=
Received: by 10.216.143.66 with SMTP id k44mr4074624wej.56.1326101299559; Mon,
 09 Jan 2012 01:28:19 -0800 (PST)
Received: by 10.223.118.10 with HTTP; Mon, 9 Jan 2012 01:28:19 -0800 (PST)
In-Reply-To: <14628854a651ab0202e3f82be9b245331cf9029a.1325965254.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188164>

Hi,

On Sat, Jan 7, 2012 at 20:43, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> While fixing the problem from a8ca786991, it introduces a regression
> regarding what happen after the multi selected file operation (ie.
> one of Ctrl-{T,U,J}) because the next selected file could not be handled
> by such a subsequent file operation.
>
> The right way is to move the fix from this commit down into the show_diff
> function. So that all code path add the current diff path to the list of
> selections.
>
> This also simplifies helper functions for these operatione which needed
> to handle the case whether there is only the current diff path or also
> a selction.

I think we need to think this more through, especially with input from
Shawn, please.

I have now find out, that git-gui has two selections in the file
lists. The first is that for the current path for what we show the
diff (the tag for this is called 'in_diff') and the the second is that
for the current list of paths which are selected ('in_sel'). The file
list operations 'staging', 'reverting', 'unstaging', work either on
'in_sel'; if that is not empty, or on 'in_diff'. The problem I've now
realized is, that these two selections share the same visual hints,
ie. a lightgray background.

The problem I tried to solve in a8ca786991 was, that adding paths to
the selection with Ctrl-Button-1 or Shift-cutton-1, didn't included
the current diff path in the subsequent file list operation. But I
would have expected it, because it was visual in the 'selection'.

My current 'workaround' is to make the two selections visually
distinguishable (and reverting a8ca786991), by using a different
background color for the 'in_sel' tag and also the italic font, so
that it is still possible to see whether the current diff path is in
the selection or not:

@@ -717,11 +717,11 @@ proc tk_optionMenu {w varName args} {
 proc rmsel_tag {text} {
 	$text tag conf sel \
 		-background [$text cget -background] \
 		-foreground [$text cget -foreground] \
 		-borderwidth 0
-	$text tag conf in_sel -background lightgray
+	$text tag conf in_sel -background SlateGray1 -font font_diffitalic
 	bind $text <Motion> break
 	return $text
 }

 wm withdraw .
@@ -3557,11 +3557,11 @@ if {$use_ttk} {
 	.vpane.files add .vpane.files.index -sticky news
 }

 foreach i [list $ui_index $ui_workdir] {
 	rmsel_tag $i
-	$i tag conf in_diff -background [$i tag cget in_sel -background]
+	$i tag conf in_diff -background lightgray
 }
 unset i

 set files_ctxm .vpane.files.ctxm
 menu $files_ctxm -tearoff 0

I'm not very pleased with this, but at least it is now possible to
visual recognize what files will be handled by a subsequent file list
operation.

Any input is more than welcome.

Regards,
Bert
