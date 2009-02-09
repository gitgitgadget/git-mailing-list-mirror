From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Add the signed-off in the commit text dialog
Date: Mon, 9 Feb 2009 16:50:18 +0100
Message-ID: <551f769b0902090750t2d6a43c4vb4944df340fc5148@mail.gmail.com>
References: <499048FD.7050803@gmail.com> <20090209154627.GJ30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:51:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYQE-0004kU-Eb
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812AbZBIPuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbZBIPuW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:50:22 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:45048 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811AbZBIPuV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:50:21 -0500
Received: by bwz5 with SMTP id 5so1463292bwz.13
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 07:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F3gcFTOsxjNyoiD9IoAI3G8t2EnsmmFThi6M91G1iOk=;
        b=my6ycQGJ5pUU0LJFCG9q/4tQLmRW/WTY3chTQhMYC0fNHtRxEpy2Z9jJZcrBPW/gKf
         Yx+o0EJnS5FCXhLkVP9hSWhl5rT2jDMeda89WeVF+ESnl7a5lZpRKCRgqUI20cMvqAFZ
         zsmIIXbOSKphZefic4NUI9BcgBPMLcKmsSdnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uY1rRR81MYMyokawvaEUwKEFnYelm/x4bxleG9KUaUMnHCDSyeyhyTdRMM8FhJLukg
         9ys0MSkx5rcdMkLaeY7kwx6tRlZmlAIGBYpt0odhuCikbv4TayRWMwz979Iuz9dMwIy5
         emkl3akPHsvN/wCkVCPG+Fr/5DucGH9QFTo7o=
Received: by 10.181.235.14 with SMTP id m14mr113511bkr.28.1234194618773; Mon, 
	09 Feb 2009 07:50:18 -0800 (PST)
In-Reply-To: <20090209154627.GJ30949@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109087>

2009/2/9 Shawn O. Pearce <spearce@spearce.org>:
> Yann Simon <yann.simon.fr@gmail.com> wrote:
>> The user can see and edit the signed-off in the commit dialog
>> before committing.
>>
>> For new lines in the commit dialog, use Text.DELIMITER for
>> plateform neutrality.
>>
>> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
>> ---
>> This patch only applies after the 2 previous patches.
>> If you want to, I could probably modify this patch so that it would
>> apply on the current origin.
>
> The other two have been applied so no need to rebase.
>
>> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
>> index 9d062cc..8f85c08 100644
>> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
>> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
>> @@ -67,6 +68,8 @@
>>   */
>>  public class CommitDialog extends Dialog {
>>
>> +     private static Pattern signedOffPattern = Pattern.compile("(.|\r|\n)*Signed-off-by: .*(\r|\n)*"); //$NON-NLS-1$
>
> Wouldn't "[.\r\n]" be easier to use here than "(.|\r|\n)"?
>
>> @@ -214,6 +217,30 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
>>               signedOffButton.setText(UIText.CommitDialog_AddSOB);
>>               signedOffButton.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).span(2, 1).create());
>>
>> +             signedOffButton.addSelectionListener(new SelectionListener() {
>> +                     boolean alreadySigned = false;
>> +                     public void widgetSelected(SelectionEvent arg0) {
>> +                             if (alreadySigned)
>> +                                     return;
>> +                             if (signedOffButton.getSelection()) {
>> +                                     alreadySigned = true;
>
> Huh.  So I can only push the checkbox once, and that after that
> its just an idiot switch?
>
> If that's really going to be how it is, maybe we should disable
> the checkbox?
>
> FWIW, git-gui actually looks for the user's Signed-off-by line in the
> text buffer.  If it can't find it, then it appends it onto the end.
> That way the user can delete the line and do the sign off again if
> they messed up somehow.
>
> And actually, given that this is a checkbox and not a button, maybe
> we should be able to *delete* the SBO line when the user tries to
> uncheck the checkbox.  Which then gets into, what if the user made
> an edit to the text and changed the SBO line, should this box get
> unchecked automatically by some form a listener on the text box?
>
> Food for thought.  I'm not sure what it should be.  But if it were
> a checkbox, as a user I'd like it to be bi-directional (both add
> and remove my SBO) and also uncheck when I edit or delete the SBO
> line in the message box.

He he, more challenging but it would be much better too!
I try to implement this when I have time.

And what should we do, when we commit a change from somebody else?
Sould we be able to modify the signed-off of the author?

Yann
