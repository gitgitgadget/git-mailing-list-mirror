From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 1/2] Work around leftover temporary save file.
Date: Tue, 15 Sep 2009 18:14:48 +0400
Message-ID: <e2480c70909150714n3b7d6018rcb5bcb42d1d78218@mail.gmail.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	 <87ab0wcsyp.fsf@users.sourceforge.net>
	 <81b0412b0909150601j74d40181pc2308f4f63b4817e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 16:14:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYo4-0008K7-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 16:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbZIOOOs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754111AbZIOOOr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 10:14:47 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:63449 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbZIOOOq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 10:14:46 -0400
Received: by fxm17 with SMTP id 17so1593941fxm.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cpsZoykWvoX20PlJoQXSzACx1GejyJTfBtnR/UquFNI=;
        b=EMFdyP1pbQCM53zV6KxNoVsGpFt8y4TDg/XjYvYTS0j4S94vqDiTyiDJEO52tDRtjm
         AKCsdpsqtxnl89sug0jXlpxCpe+YXhfF49xG7ooIovgtlfMW04eqEYWATwIVTVj8RSh/
         FRqTC+IFCMQN59kUAZhaQHsrddMUsiULspto4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dr7yvhvmN+LHVTTbC3+RvYGdDh2XBUigkm95yeOge2DpEd6vTdRbThwH+sjJ57iCRK
         BiHkZON/93NMGEa7nexVXYH99S5pZYBNulRpaVFZWDdl0vsqAsn1N1N4Kxa6XAyUUAhK
         sGlDZycor/lunC5ploGEJ7N0WbSYJmW5NNAbA=
Received: by 10.223.22.133 with SMTP id n5mr2692278fab.16.1253024088824; Tue, 
	15 Sep 2009 07:14:48 -0700 (PDT)
In-Reply-To: <81b0412b0909150601j74d40181pc2308f4f63b4817e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128567>

On Tue, Sep 15, 2009 at 5:01 PM, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> On Tue, Sep 15, 2009 at 11:26, Pat Thoyts
> <patthoyts@users.sourceforge.net> wrote:
>>
>> If a file exists and is hidden on Windows the Tcl open command will
>> fail as the attributes provided in the CREAT call fail to match thos=
e
>> of the existing file. Forcing removal of the temporary file before w=
e
>> begin solves any problems caused by previous failures to save the
>> application settings. An alternative would be to remove the hidden
>> attribute before calling 'open'.
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>> =C2=A0gitk | =C2=A0 =C2=A01 +
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/gitk b/gitk
>> index 1306178..a0214b7 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -2526,6 +2526,7 @@ proc savestuff {w} {
>> =C2=A0 =C2=A0 if {$stuffsaved} return
>> =C2=A0 =C2=A0 if {![winfo viewable .]} return
>> =C2=A0 =C2=A0 catch {
>> + =C2=A0 =C2=A0 =C2=A0 if {[file exists ~/.gitk-new]} {file delete -=
force ~/.gitk-new}
>
> maybe another gitk instance is writing it at exactly same moment
> in time? Writing is known to take a few moments. Especially on Window=
s.

Then deleting would fail, because on Windows opened files cannot be
deleted (unless they are opened in a special way that permits it).
