From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 2/3] git-p4: Search for parent commit on branch creation
Date: Mon, 23 Jan 2012 13:49:12 +0000
Message-ID: <CAOpHH-Xy2DnoyL_sYjz8umbOg3Hd7iirUzUnfLmYdcg7Oiw6fQ@mail.gmail.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-3-git-send-email-vitor.hda@gmail.com> <7v7h0ld58z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 14:49:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpKHU-0005IP-Os
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 14:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab2AWNtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 08:49:49 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41721 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752311Ab2AWNto convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 08:49:44 -0500
Received: by lahc1 with SMTP id c1so1614900lah.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yBUheswa0bTaglGschmugoqmTvV2dcupDAvndP5vEF0=;
        b=PtyXf0LYG+dwJ/q36W3tuMlb3zbcwrAg1PslOB4nQ+b0l7r+6etRwe/vCRhzcQsJIV
         Zow1SA1I4KNOCDFl9dEbOUhaIsy27eh/FLqFWm/16kfl1OCPTk/McLhUtDT70N2CbCJw
         cHxnDB83azeAECoBby4ehrBx5jrE8e2+1V2S8=
Received: by 10.152.122.38 with SMTP id lp6mr4310440lab.13.1327326583297; Mon,
 23 Jan 2012 05:49:43 -0800 (PST)
Received: by 10.152.105.179 with HTTP; Mon, 23 Jan 2012 05:49:12 -0800 (PST)
In-Reply-To: <7v7h0ld58z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188989>

Hi Junio,

On Sat, Jan 21, 2012 at 4:55 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> A fast-import "checkpoint" call is required for each comparison beca=
use
>> diff-tree is only able to work with blobs on disk. But most of these
>> commits will not be part of the final imported tree, making fast-imp=
ort
>> fail. To avoid this, the temporary branches are tracked and then rem=
oved
>> at the end of the import process.
>>
>> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>> ---
>
> It might make sense to squash 1/3 with this patch; the definition alo=
ne
> without any actual user would not be very useful and won't help hunti=
ng
> for breakages, if exists, in the future.

Makes sense. WIll correct as you suggest in v3.

>> @@ -2012,7 +2014,27 @@ class P4Sync(Command, P4UserMap):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parent =3D=
 self.initialParents[branch]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0del self.=
initialParents[branch]
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.commit(descrip=
tion, filesForCommit, branch, [branchPrefix], parent)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parentFound =3D Fal=
se
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if len(parent) > 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tempBranch =
=3D os.path.join(self.tempBranchLocation, "%d" % (change))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if self.ver=
bose:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pri=
nt "Creating temporary branch: " + tempBranch
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.commit=
(description, filesForCommit, tempBranch, [branchPrefix])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.tempBr=
anches.append(tempBranch)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.checkp=
oint()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for blob in=
 read_pipe_lines("git rev-list --reverse --no-merges %s" % parent):
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blo=
b =3D blob.strip()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =
len( read_pipe("git diff-tree %s %s" % (blob, tempBranch)) ) =3D=3D 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0parentFound =3D True
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0if self.verbose:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0print "Found parent of %s in commit %s" % (branch, blob)
>
> ... also this looks excessively deeply nested, which is a sign that i=
t
> might be a good idea to refactor this part into a separate helper fun=
ction
> or something.

I have to agree with you. Since v3 is required, I'll also include this
fix along.

Thanks,
Vitor
