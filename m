From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 2/2] git-gui: handle bare repos correctly
Date: Fri, 20 Feb 2009 01:34:30 +0100
Message-ID: <cb7bb73a0902191634n30f97c24t4d1840f5660c3eb3@mail.gmail.com>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1235006145-16760-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <alpine.DEB.1.00.0902190322470.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:36:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJN4-0000Oj-IL
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbZBTAee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbZBTAed
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:34:33 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:48428 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbZBTAec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:34:32 -0500
Received: by ewy14 with SMTP id 14so640991ewy.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 16:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xk7IiwfNnGW6x97HECf/iG9Vm9AZC7EMnT4OUN12ZqY=;
        b=EvPsofPn2XHtbzP/c1mBPKOoeIrSD0rNmmO4xHjxt4bNFppWS+jxeb57ojLX+ISi8j
         og+EtkGFsFzi7rWHGLIhd3B99kva68l7bAWxgokQpVynea8FE9uNe9ABoDd+ky4o0Zs3
         lAvWMzCWohW7MHSUUE2Upay0FMrJglGtXvkWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SjB6GyR5AGz2WL/mu/0biHECbUeG5k4Ru8qEkQ3wPQlbN/3VmsRFbcrF+rRnk/aA3y
         fffk9s+eyP1CwxCdk3Gp156pFI03eZZwtuLItt49OQZ+OiOFM1EbSegFOq6g6/ei8RDw
         WndoKX+N4CcA9BI0tDVElsWK2Et+Fu0rILQYk=
Received: by 10.210.81.10 with SMTP id e10mr114171ebb.194.1235090070795; Thu, 
	19 Feb 2009 16:34:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902190322470.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110773>

On Thu, Feb 19, 2009 at 3:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>>
>> +proc is_bare {} {
>> +     global _isbare
>> +     global _gitdir
>> +     global _gitworktree
>> +
>> +     if {$_isbare eq {}} {
>> +             if {[is_config_true core.bare]
>> +                     || ($_gitworktree eq {}
>> +                             && [lindex [file split $_gitdir] end] ne {.git})} {
>> +                     set _isbare 1
>> +             } else {
>> +                     set _isbare 0
>> +             }
>> +     }
>> +     return $_isbare
>> +}
>
> git rev-parse --is-bare-repository anyone?

As mentioned elsewhere, git-gui is supposed to be backwards compatible
with git 1.5.0; --is-bare-repository was introduced in 1.5.2. What I
can do is try that and fall back to this other implementation
otherwise.

>> @@ -1913,7 +1931,7 @@ proc do_gitk {revs} {
>>               }
>>
>>               set pwd [pwd]
>> -             if { $_gitworktree ne {} } {
>> +             if { ![is_bare] } {
>
> Why is this change needed at all?

Because the worktree being undefined in non-bare repositories is an
error and should raise consequently.

>> @@ -2317,10 +2335,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>>  #
>>  menu .mbar.repository
>>
>> -.mbar.repository add command \
>> -     -label [mc "Explore Working Copy"] \
>> -     -command {do_explore}
>> -.mbar.repository add separator
>> +if {![is_bare]} {
>> +     .mbar.repository add command \
>> +             -label [mc "Explore Working Copy"] \
>> +             -command {do_explore}
>> +     .mbar.repository add separator
>> +}
>
> How did you make sure that there are no more places?

I looked at the code and tested it.

> (I, for one, would expect the standard mode of staging to fail in a bare
> repository.)

That's the reason why the only thing you can do in bare repositories
is git gui blame.

-- 
Giuseppe "Oblomov" Bilotta
