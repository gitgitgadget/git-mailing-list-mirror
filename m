From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] Ensure proper setup of git_dir for git-hash-object
Date: Sat, 28 Feb 2009 14:20:32 -0700
Message-ID: <51419b2c0902281320neec7960vfbe7b806c8db56ca@mail.gmail.com>
References: <1235851009-16739-1-git-send-email-newren@gmail.com>
	 <7v3adyffax.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 22:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdWdH-0003HU-SQ
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 22:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbZB1VUf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 16:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbZB1VUf
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 16:20:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:42764 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbZB1VUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 16:20:35 -0500
Received: by gxk22 with SMTP id 22so3743748gxk.13
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mcvfoMOn0jcVMTsXwdNNhUR/cKDx6EQd+4ZP7WWV5kE=;
        b=CbjPI0C34WTOxrdcBD7FKeKRJFeWSAPrT68V1WIZWAqfu5YhmduSTuajvuy4kbgLBL
         Xmos5qFEDoyVy51o08cIqRno4ME6OTMTNbv4F7nUtlkRIxML7zbXPlUb8DY9bBC/AWfX
         y3zXME0C2zBcu+0Ztn0Jx2NLzYCHB6NLEy3mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f2HAAzXwsZpe3CtmbiK+vVC3RGrSVrOeHnNEsP+Laf7T3WNMZubw/MoVZQIhN4BfWc
         aKZyXKotw3QgMjmIV3RFzE4luAO1SiCPhiZzDkAHBCS8T49jFE985BfXd74yYyMYR02v
         DY3upPawh+81Srvu9qpmtPjmJhTCwZtCtRQH4=
Received: by 10.151.38.12 with SMTP id q12mr6811985ybj.68.1235856032150; Sat, 
	28 Feb 2009 13:20:32 -0800 (PST)
In-Reply-To: <7v3adyffax.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111794>

On Sat, Feb 28, 2009 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> newren@gmail.com writes:
>
>> Without this patch:
>> $ mkdir tmp
>> $ cd tmp/
>> $ git init --bare
>> Initialized empty Git repository in /home/newren/floss-development/g=
it/tmp/
>> $ echo hi | git hash-object -w --stdin
>> error: unable to create temporary sha1 filename .git/objects/45: No =
such file or directory
>>
>> fatal: Unable to add stdin to database
>> $ echo hi | git --git-dir=3D. hash-object -w --stdin
>> 45b983be36b73c0788dc9cbcb76cbb80fc7bb057
>
> Does the patched version work without -w option? =C2=A0Should it?

Yes, the patched version works with or without the -w option (at least
in my testing -- maybe you know of a case I'm missing?)  I would
certainly expect it to work in both cases.

I basically arrived at the patch by realizing that git_config was
setting git_dir incorrectly as a side-effect, causing
setup_git_directory to notice it was already set and not try any of
it's more detailed logic to figure out the correct value.  Then I did
some grepping and noticed that other source files (archive.c,
builtin-apply.c, builtin-diff, etc., etc.) call
setup_git_directory[_gently] before git_config, and that hash-object.c
seemed to be the only one that didn't follow that trend.
