From: Daniel Finnie <dan@danfinnie.com>
Subject: Re: git ls-files -X option is relative to repo root
Date: Fri, 13 Feb 2015 16:19:28 -0500
Message-ID: <CAG4vEKP760_sq1fsJD_1jjz0_G+T8NosSXDqx0bvQy4tPVz5JQ@mail.gmail.com>
References: <CAG4vEKM-2sy0z3=YLS+rgH99w6ukdcNBode9CAh4C4t9eSa02A@mail.gmail.com>
 <xmqqmw4hmtlw.fsf@gitster.dls.corp.google.com> <xmqqiof5mt0q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMNes-0005fM-MR
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbbBMVUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:20:11 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:50602 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbbBMVUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:20:10 -0500
Received: by mail-we0-f179.google.com with SMTP id u56so18976975wes.10
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 13:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=98WC9KqMdFFCqk9vnGApVCS81a6x9Yw85JQbVRBijGM=;
        b=k2+864EmSiggaiv5hrogb2tiwOg8xxzOFgzTRcNBOpk84YHzzPaIerlOAHd/fNouxt
         M6tgzrtVjXJJiqOCLd5BFbBZgg56fIYM0l7EzCJLo7Fdf/TpqW6qFhEN2z+OeN3N92Dt
         Zr6uuhrRbSh7DA77+UwTObw4oeqahvCgM23N/A9Ktyi9S37hczDhtqmZJchLZu5D9aBP
         CDpV/a6RIyudEyNeUZpNqPq1n2qd/vRtkPr19RXADGR38eglR2yQ+mmcFHIjw/dPHhqF
         82r7c2GWul9fooXuPnWXpQOvQ5AdfBMggSPxstrWuFRKCgjBDAeVTMQErpr9GNNnVyqE
         BxEQ==
X-Gm-Message-State: ALoCoQnjI/ialTS+XbN2R2fZ7N2SJsauelOQ7x7UbYAIoJ640hn3L8tJduc0rI8t3jKaDRGc+g11
X-Received: by 10.194.189.77 with SMTP id gg13mr21913461wjc.81.1423862408898;
 Fri, 13 Feb 2015 13:20:08 -0800 (PST)
Received: by 10.216.191.19 with HTTP; Fri, 13 Feb 2015 13:19:28 -0800 (PST)
In-Reply-To: <xmqqiof5mt0q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263837>

Hi Junio,

Thanks for the info and backstory.  I didn't realize that the paths in
the file specified by --exclude-from would be relative to the project
root.  That makes my original use case kind of silly (it's a long
story, but I was curious which files were ignored by a subset of my
.gitignore files).  This makes the example I gave before wrong in that
the contents of example_dir/.gitignore should have been relative to
the project root.

There are 2 sets of paths that can be relative to the working
directory or the project root with --exclude-from:
* The path to the file containing exclusion rules
* The paths of the exclusion rules themselves (the contents of the
file from the previous bullet point)

I now see why the second needs to be relative to the project root.  I
still think it's more intuitive for the first (the path to the file
containing exclusions) to be relative to the current directory.  Your
example of `git ls-files -X /var/tmp/exclude -i` uses an absolute
path, let's look at one with a relative path.  Say you wanted to check
what files were being ignored from your .git/info/exclude file from a
subdirectory of your project.  I would expect to run `cd subdirectory
&& git ls-files --ignore --other --exclude-from=../.git/info/exclude`.
The correct command, though, is `cd subdirectory && git ls-files
--ignore --other --exclude-from=.git/info/exclude`, even though I'm in
a subdirectory.

Do you have any comments on why the path in --exclude-from=<path> is
relative to the project root?

Thanks,
Dan


On Fri, Feb 13, 2015 at 3:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...  It does not make sense to allow where you are
>> to affect behaviour of the command, i.e. in these two invocations of
>> ls-files:
>>
>>       git ls-files -X /var/tmp/exclude -i
>>         cd example && git ls-files -X /var/tmp/exclude -i
>>
>> if the same line in /var/tmp/exclude meant completely different
>> things, it would be crazy.
>
> To put it another way, think of --exclude-from as a way to specify a
> replacement for .git/info/excludes, and --exclude-per-directory as a
> way to specify a replacement for the in-tree .gitignore files.
>
> Historically, we did not have the --exclude-standard option from the
> beginning, and only after we gained experience with --exclude-from
> and --exclude-per-directory in our scripts, the --exclude-standard
> was added to codify the (then-) best-current-practice after the fact,
> and we used --exclude-from for exactly that purpose before then.
>
> cf. 8e7b07c8 (git-ls-files: add --exclude-standard, 2007-11-15)
