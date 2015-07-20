From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 12:59:32 -0700
Message-ID: <xmqqoaj6y50b.fsf@gitster.dls.corp.google.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 21:59:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHHDw-0007ho-R5
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 21:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbbGTT7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 15:59:36 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34221 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbbGTT7f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 15:59:35 -0400
Received: by pdbbh15 with SMTP id bh15so60874529pdb.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zZsmaN9uoY8eeEHfxuMZ1XG/Dob/zrATlO/Dh7uX1jI=;
        b=zkQsZhKv03ZqrVirzz2iIgFkwcEJ/NA0Z6OUMeOyYKJ9WLGbm8y6lup22c/vKqQOo0
         Y+bUIe4rnqcqnJTjEI5KjxonlSNn0Plc7BIQ4zKVGEo5OlIYZbY2uHbcxlo1/nTDbsK/
         rIujRvAB10KtxPu/sZi1LD4WdY84NgXZ6jAK/EBJ2D77vfIEjQUj1LicIkJ6+PbFIwEJ
         kJlx8emb5OdHLi2c/uPhzhbrACNjeRlV3kFtBjDegLB10zoFjC28G391wmjktq/BMKlV
         Q5F4Uy9yb/jG+YQLC1sMxzKlzhKWHU0fIt13bS9F5dZ0cboZBzDG5eEY6yU41Q5ILNxT
         zybA==
X-Received: by 10.66.121.74 with SMTP id li10mr2657545pab.73.1437422374826;
        Mon, 20 Jul 2015 12:59:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id r4sm23381032pap.8.2015.07.20.12.59.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 20 Jul 2015 12:59:33 -0700 (PDT)
In-Reply-To: <1437416790-5792-5-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Mon, 20 Jul 2015 19:26:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274351>

Philip Oakley <philipoakley@iee.org> writes:

> +git-send-email invokes the cc-cmd like this:
> +
> +	$cc-cmd $patchfilename
> +
> +Thus the patch itself can be processed to locate appropriate email address
> +information if required.

That's not even a valid command line (cc-cmd cannot be a shell
variable name), so why bother writing it that way?  Rather

    The program that is specified by `cc-cmd` is invoked by `git
    send-email` with the name of the patch file as an argument;
    the program can read from it and customize its output based on
    what the patch file contains.
    
or something like that, perhaps.

> +
> +A simple solution for a basic address list is to create a 'cc-cmd' file
> +(executable) which provides a list of addressees:

There is no "problem" stated here that requires your "solution".  In
fact, what problem are you solving?

> +	#!/bin/sh
> +	echo <<\EOF
> +	person1@example.com
> +	person2@example.com
> +	EOF

That is one simple and denegerate use case; if the program does not
need any information from the patch file, it surely has an option
not to look at it.  But it is not an interesting usage.

If you want to add a single example to illustrate how cc-cmd (or
to-cmd, or anything that goes thru recipients_cmd()), you should
have an example that reads the input and then adds a few hardcoded
one.

	#!/bin/sh
	# always send it to the logger service
        echo "patchlog@example.com"
	# tell the bug tracker as necessary
	if fixes=$(sed -ne 's/^Fixes bug#\([0-9]*\)/\1/p' "$1")
        then
		echo "bugs+$fixes@example.com"
	fi

or something silly like that.

And this ...

> +Simply, using `cat cc-cmd` as the --cc-cmd (with cc-cmd as the text file
> +of email addresses), does not work as expected as the invocation becomes:
> +
> +	$cat cc-cmd $patchfilename
> +

... and the rest of the patch is unnecessary noise to a reader who
read that the single argument to the program is the name of the
patchfile, I think.  You were trying to avoid the same confusion
caused by the sketchy documentaiton, and you already "solved" that
problem by telling the reader what the command takes as its input.

> +    --cc-cmd='cat cc-cmd #'

This heavily depends on the current implementation that happens to
pass the command line string to a shell.
