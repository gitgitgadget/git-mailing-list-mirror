From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] cat-file: add --follow-symlinks to --batch
Date: Mon, 11 May 2015 10:45:03 -0700
Message-ID: <xmqqzj5bdn4w.fsf@gitster.dls.corp.google.com>
References: <1431203769-11855-1-git-send-email-dturner@twopensource.com>
	<1431203769-11855-3-git-send-email-dturner@twopensource.com>
	<554F0378.2070803@kdbg.org> <1431363819.15048.2.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 11 19:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrrlR-0006jc-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbbEKRpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:45:09 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35099 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbEKRpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:45:07 -0400
Received: by igbyr2 with SMTP id yr2so77299473igb.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=t8+cMc9J47DS9TwSS4eOKB5N5KN9S1W+2qAi0r/7xJ4=;
        b=zsyxq36IQ0jvjxTlXa3maEC/9sENFMIDFgdiZgJ0K+V4WySrZBA1Z2FGUU9jPHjdua
         jNOeci2z3lZ+MeEimWfRsTN+bpQsFP8vuSg5CFtEdbyf5cp4S2wS38I+9p2MQot1bYrB
         OghfcuCIemV6CVDNjEm0s8CQxes0ysEfXdhRR7qXxOgBWSpeilwCv4+Lcs6B668hYdNO
         60wAOecqo0vRqXVLw2A73bli4F5DWe9Bgx8ptbXQ9dbIeaR9iuCs60FyrrBphtwIUfbE
         NcfMbXIivHoIPs5MV7x9hyEJfiwn9MN8q/rOKClociCFNLIMeSKCeUCH5oz3GcOe4VBr
         FiYQ==
X-Received: by 10.50.103.97 with SMTP id fv1mr1196646igb.27.1431366306646;
        Mon, 11 May 2015 10:45:06 -0700 (PDT)
Received: from gitster.dls.corp.google.com ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id kc1sm338478igb.0.2015.05.11.10.45.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 10:45:05 -0700 (PDT)
In-Reply-To: <1431363819.15048.2.camel@ubuntu> (David Turner's message of
	"Mon, 11 May 2015 13:03:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268802>

David Turner <dturner@twopensource.com> writes:

> On Sun, 2015-05-10 at 09:06 +0200, Johannes Sixt wrote:
>> > +	ln -s loop2 loop1 &&
>> > +	git add . &&
>> > +	git commit -am "test"
>> > +'
>> 
>> These tests will fail on a file system that does not support symbolic 
>> links, such as on Windows. Would you please separate the test cases 
>> (that come after the setup) into two groups:
>> 
>> 1. Those that inspect the filesystem and expect a symbolic link. Protect 
>> these tests with a SYMLINKS prerequisite.
>
> I believe that none of these require that.
>
>> Note that you do not require a symlink enabled file system to generate a 
>> repository with symlinks, i.e., you don't have to protect the setup code 
>> with SYMLINKS. For this, you can use 'test_ln_s_add' instead of the 
>> above sequence of 'ln -s' followed by a single 'git add .'.
>
> Will fix, thanks.

Yeah, thanks. There doesn't seem to be any reason to forbid this new
feature from being used on symlink-challenged filesystem (after all,
"cat-file --batch" should run fine in a bare repository) and the
suggestion makes sens to me.

>> > +
>> > +echo $hello_sha1 blob $hello_size > found
>> 
>> This seems to be used only in the next test. Please move it inside 
>> test_expect_success.
>
> This is used in a number of tests, e.g this one:

Perhaps then the preparetion of 'found' is part of this thing:

    test_expect_success 'prep for symlink tests' '

A micronit on style; please drop SP between redirection and its
target (but have one before redirection), i.e.

	echo ... >found
	command <input

Thanks.

>
>> > +test_expect_success 'git cat-file --batch-check --follow-symlinks
>> > works for in-repo, same-dir links' '
>> > +	echo HEAD:same-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
>> > +	test_cmp found actual
>> > +'
