From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Wed, 11 Nov 2015 12:53:05 -0800
Message-ID: <CAGZ79kZTiGGL0t-CkeuWDfzX-pK_Lu8PZzE1sutq2jR_23B5xg@mail.gmail.com>
References: <1446853737-19047-1-git-send-email-sbeller@google.com>
	<563DBDDA.2000106@kdbg.org>
	<CAGZ79kaZ0W5q8=iowbSTJY_mDNNYc6qdTszcWDDDCtYfZyeK_Q@mail.gmail.com>
	<5643A9A0.50105@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:53:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwcOG-0001ul-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbbKKUxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:53:08 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35341 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbKKUxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:53:06 -0500
Received: by ykba77 with SMTP id a77so69855085ykb.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2uBik63nmfJS9h56S1xwcfag0fTIRMVo7yjYyaFcclk=;
        b=BBVbJBeoT6WCKlCxkKk8n7p/P7ZGz8QYy4YOv41A3keMZY2HCVA6vZIrULlHN24Krb
         0WeQv4LmUZCUDpQ5OwRzEDmWYBqH7e8Vs5XoYK+I0c9N3j0YzDqAjYwvetdZHPY6vIQ4
         eawt7ip0TuJTW9BLroRpWvVNrJScQ/Jh6ns8qrR46HrC0ejbSVrQP9wp/f/4HeaIXU2V
         B+NAOyQ6hqkt5iToIoT2sxR3vcEkxTZHfrXUvguKInQwHpmHOIMQ/HsLWI58R1Nz8N5T
         aEbn9udQFRn9B+h8MFbpumuOYCfbag6rmD5hsfjNdxQCcatO4brolvOiyZvTeDMWvlCx
         I3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2uBik63nmfJS9h56S1xwcfag0fTIRMVo7yjYyaFcclk=;
        b=jcP2vrMHAVF6SPthWm/F0C3UvGDqci+cTvpv9SgqEa/CFwoU5U1vdaQ2evMZOfiA7i
         t1AflZTGGEv2Uelk6DTqzlsLcmJQLcA+U87+lnznArn3BHgpwZf4m6D6B3RFt5L0nMsa
         PrSr+oIkGxrGFHjp/w1kuJuX2WEFEWWyH+75xBllULIeat7EH1rzWkovlHm+7Adv3Lxg
         q30wwSvIIjMnq80JkF5PebveBiAX7950QPRmsCgiFO0KUTVbjmSE1hEY7AOUUpkjZDwu
         uTc0VGqHJpTmgWI60D2mBV0nnbouC9ZZgnWXkljwKG/RQp43d1uomRjGNu5HI6phrZJ0
         idmg==
X-Gm-Message-State: ALoCoQmkOcd4r9dqGBM4ZFBvWX6X8VqfTijMj1EX5vJyTk5FBhFybMpxQ1cGI/qMIlhCYDjVNoVo
X-Received: by 10.13.199.133 with SMTP id j127mr12088479ywd.176.1447275185805;
 Wed, 11 Nov 2015 12:53:05 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 12:53:05 -0800 (PST)
In-Reply-To: <5643A9A0.50105@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281200>

On Wed, Nov 11, 2015 at 12:48 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> So maybe that was not the right thought and we do have to special case
>> SIGTERM here?
>
>
> I wonder why task_finish() callback gets to choose a signal. The point here
> is, IIUC, when one child dies, the others must be halted, too. SIGTERM seems
> to be the only sensible choice.

SIGKILL would also do?

In case you know your children, you can also send a SIGUSR1 or SIGUSR2.

Or if you want to quit the top level program, but want to keep going with some
of the children (repacking, garbage collection, networking stuff), you
way want to
decouple them using SIGHUP ?

So I am not convinced SIGTERM is the only true choice here. And because I
have no idea which of the signals may be useful in the future, I decided to
go with all of them.
