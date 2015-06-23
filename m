From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 23 Jun 2015 13:37:34 -0700
Message-ID: <xmqqegl2cga9.fsf@gitster.dls.corp.google.com>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<xmqqwpyucjj1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Uwv-0004k1-UD
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299AbbFWUhi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 16:37:38 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36678 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbbFWUhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:37:36 -0400
Received: by iecvh10 with SMTP id vh10so20079680iec.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Q3LVsZLvO3TmQq33OQuZb1MR843rwWkUaG6WTJIyjh4=;
        b=tXjyV3M83mH7dsdcwmUudHD5FqRiLgm41pwnY7CTJYmveaxr0HrD+lBVu7gBuFXq4g
         FjjHJ1LNlCig+PqP596sD7SZDm4KUVH5pq4HUYNwrolTBee/ocwxWMvhzRBZQCKMZjeb
         vPCXw8HTZxxQLNh+BBecCTlXg87EmgZ6GgE4rHKHsv8qzI4yiqTMUfQGBg9wPqY3Yvr4
         whQflEy3hKEBINqGq8q3nNjQfUjsUeF8Ls0K+YP9egADdHkOviCYEWD+iE62o5URMgZE
         O8faQRrX3VRf2aOZ0niLVTtTSDHwVMiDq0qMPZxLx68vTTJF1gV3W4AREKpZ5Ihdh5+p
         If8g==
X-Received: by 10.50.138.136 with SMTP id qq8mr4747168igb.27.1435091856234;
        Tue, 23 Jun 2015 13:37:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id d4sm501319igl.1.2015.06.23.13.37.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 13:37:35 -0700 (PDT)
In-Reply-To: <xmqqwpyucjj1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Jun 2015 12:27:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272508>

Junio C Hamano <gitster@pobox.com> writes:

> Galan R=C3=A9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>
>> +test_rebase_end () {
>> +	test_when_finished "git checkout master &&
>> +	git branch -D $1 &&
>
> Is this one guaranteed to succeed?  Do we want to consider it a
> failure to remove "$1" (e.g. dropTest)?
>
>     $ git branch -D no-such-branch ; echo $?
>     error: branch 'no-such-branch' not found.
>     1
>
> If dropTest branch did not exist before the test that begins with
> a call to this function, what happens?
>
> Besides, a function that must be called at the beginning of a test
> piece has a name that ends with _end?  That sounds funny, no?

Ah, scratch this last paragraph.  I didn't see this is a
multi-command "when_finished".

But other parts of what I said still stands.  For example, even in a
multi-command "when_finished", "git branch -D $1 &&" if the main
body of the test failed to create the branch "$1", that command
would fail and skip the remainder of the clean-up, so the first
point above is still suspect.
