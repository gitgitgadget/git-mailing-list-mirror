From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 21:09:05 +0200
Message-ID: <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<20121024180807.GA3338@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR6KO-0002c1-EW
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 21:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249Ab2JXTJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 15:09:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59005 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965086Ab2JXTJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 15:09:06 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so797386obb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jejjvDwZocN1OQaU7ly6gljP2ZFUicOrmfhFEupDYtg=;
        b=xRvq8hxD9un6VuCbjOpVT+jVwYKYpiv3ts0ivsFZbhb7hw8AyF0Rj2GNYJH9oMnFHO
         1Nu7fEAqScVDdVr9bt8io79+jmCWIPtG2BXcmMJBR/1OnnqEOrXUUEHbqHDeWyDYhR7Z
         4mGEy++uECfVWWYWPBLKRAk2QC7DhbY2Vft+htM8nyfrtObiAbbdAMBEjjuBjz5AVE7g
         vvh/8HBV0fNBOSEOsYsRF/Vo6MGYAxCghzJvj9c510LJLHC0y+pzvMXPWQGrlnZv85W6
         x1G5ftndsX+HCas2vHWt/BiFCRPH7/THL4KyDBbxrV/1z2TsNimB3SDnXo4D3NfX0ela
         HNBg==
Received: by 10.60.32.19 with SMTP id e19mr15232682oei.9.1351105745622; Wed,
 24 Oct 2012 12:09:05 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 12:09:05 -0700 (PDT)
In-Reply-To: <20121024180807.GA3338@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208317>

On Wed, Oct 24, 2012 at 8:08 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Felipe,
>
> Felipe Contreras wrote:
>
>> This test is completely wrong.
>>
>> 1) Where are the marks file?
>> 2) master..master shouldn't export anything
>
> Why shouldn't master..master export anything?  It means "update the
> master ref; we already have all commits up to and including master^0".

Does it mean that? I don't think so, but let's assume that's the case.

We don't have all those commits; without the marks we have nothing. Or
what exactly do you mean by 'we'?

Go to your git.git repository, and run this:

% git git init /tmp/git
% git fast-export master^..master | git --git-dir=/tmp/git/.git fast-import

What do you expect? I expect a single commit, and that's what we get,
now do the same with 'master..master', what do you expect?

How about 'git fast-export ^master'? Do you expect to get anything
there? Or what about '^master master'?

Without marks these idioms don't make any sense. Now lets assume that
marks were meant to be there.

If 'master..master' is supposed to update master, then what is
'master' supposed to do?

% git fast-export --{im,ex}port-marks=/tmp/marks master..master

vs.

% git fast-export --{im,ex}port-marks=/tmp/marks master

Either way, my patch will make 'master..master' throw a reset (if the
marks are present, I haven't tried without them), I don't think it
should, but that's a different story, and a different patch fix.

> The underlying problem is that fast-export takes rev-list arguments as
> parameters, which is unfortunately only an approximation to what is
> really intended.  Ideally it would separately take a list of refs to
> import and rev-list arguments representing the commits we already
> have.

The commits we already have (exported before) are stored in the marks.
Maybe we can store the refs there as well, but that would not change
the semantics of refspecs, nor the fact that we need the marks.

Cheers.

-- 
Felipe Contreras
