From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Fri, 21 Aug 2015 11:01:50 -0700
Message-ID: <xmqqmvxk5xm9.fsf@gitster.dls.corp.google.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 21 20:01:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSqdZ-0006rk-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 20:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbbHUSBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 14:01:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32835 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbHUSBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 14:01:52 -0400
Received: by pacgz8 with SMTP id gz8so1537348pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=abd4G1f3VuZQFeIJG0ZmdtKXjHmqMwQynvxbQuoxqxc=;
        b=NZJsvQ14mtBeZ0X/C22ZVnIN338ZX4w8uK+Xu2QhIw7pRN78AHDztqy3DhEUaWYL4n
         7clMe6nSR6pGEURo8Tycnb/gu+Vh58yBJr0yM/423UNPwwXNWMFJW0luFgHio894OkBx
         gqAq1IJp3EAX2IgyohKharIbmWAERIRVu021vS24krJAGgRAtaomo8cnsowRNTGTtswu
         QZ50D45ZYd02KeqZ3hmPIdoawGTsginMb6liAraSmJ8UkNWwcPhogGWarkMFJJBASyyJ
         S9AtlCS+yGVr2PI3JRnyJdHimaw6Nat9ZH+rrQ0Dptnpz9Blf1qttckGaqaA57YKjLGP
         2nTw==
X-Received: by 10.66.252.72 with SMTP id zq8mr19357093pac.7.1440180112026;
        Fri, 21 Aug 2015 11:01:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id bz1sm8502948pbb.85.2015.08.21.11.01.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 11:01:51 -0700 (PDT)
In-Reply-To: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 21 Aug 2015 19:19:38
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276318>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> PROBLEM:
> We run P4 servers on Linux and P4 clients on Windows. For an unknown
> reason the file path for a number of files in P4 does not match the
> directory path with respect to case sensitivity.
>
> E.g. `p4 files` might return
> //depot/path/to/file1
> //depot/PATH/to/file2
>
> If you use P4/P4V then these files end up in the same directory, e.g.
> //depot/path/to/file1
> //depot/path/to/file2
>
> If you use git-p4 then all files not matching the correct file path
> (e.g. `file2`) will be ignored.
>
> SOLUTION:
> Identify path names that are different with respect to case sensitivity.
> If there are any then run `p4 dirs` to build up a dictionary
> containing the "correct" cases for each path. It looks like P4
> interprets "correct" here as the existing path of the first file in a
> directory. The path dictionary is used later on to fix all paths.
>
> This is only applied if the parameter "--ignore-path-case" is passed to
> the git-p4 clone command.
>
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Thanks.  A few comments.

 - Have you checked "git log" on our history and notice how nobody
   says "PROBLEM:" and "SOLUTION:" in capital letters?  Don't try to
   be original in the form; your contributions are already original
   and valuable in the substance ;-)

 - I think I saw v3 yesterday.  It would be nice to see a brief
   description of what has been updated in this version.

I do not do Perforce and am not familiar enough with this code to
judge myself.  Will wait for area experts (you have them CC'ed, which
is good) to comment.

> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..61a587b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1931,7 +1931,7 @@ class View(object):
>                  (self.client_prefix, clientFile))
>          return clientFile[len(self.client_prefix):]
>  
> -    def update_client_spec_path_cache(self, files):
> +    def update_client_spec_path_cache(self, files, fixPathCase = None):

I didn't check the remainder of the file, but I thought it is
customery *not* to have spaces around '=' when the parameter is
written with its default value in Python?

> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
> ...
> +test_expect_success 'Clone the repo and WITHOUT path fixing' '
> +	client_view "//depot/One/... //client/..." &&
> +	git p4 clone --use-client-spec --destination="$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		# This method is used instead of "test -f" to ensure the case is
> +		# checked even if the test is executed on case-insensitive file systems.
> +		cat >expect <<-\EOF &&
> +			two/File2.txt
> +		EOF

I think we usually write the body of the indented here text
(i.e. "<<-") indented to the same level as the command and
delimiter, i.e.

	cat >expect <<-\EOF &&
        body of the here document line 1
        body of the here document line 2
        ...
        EOF

> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'

I think you used to check the result with "find .", i.e. what the
filesystem actually recorded.  "ls-files" gives what the index
records (i.e. to be committed if you were to make a new commit from
that index).  They can be different in case on case-insensitive
filesystems, which I think are the ones that are most problematic
with the issue your patch is trying to address.

You are verifying what the set of "canonical" paths should be by
checking ls-files output.  I think that is what you intended to do
(i.e. I am saying "I think the code is more correct than the earlier
round that used find"), but I just am double checking.

> +test_expect_success 'Add a new file and clone the repo WITH path fixing' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +
> +		mkdir -p One/two &&

A blank after 'cd' only in this one but not others.  A blank line is
a good vehicle to convey that blocks of text above and below it are
logically separate, but use it consistently.  I _think_ this blank
line can go.

> +		>One/two/File0.txt &&
> +		p4 add One/two/File0.txt &&

Thanks.
