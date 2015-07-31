From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: remove dead code
Date: Fri, 31 Jul 2015 09:41:37 -0700
Message-ID: <xmqqr3no5lfi.fsf@gitster.dls.corp.google.com>
References: <1438301956-1658-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLDNS-00032p-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 18:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbbGaQlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 12:41:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34422 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbGaQll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 12:41:41 -0400
Received: by pacan13 with SMTP id an13so44293991pac.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bOpxj+zJSoxdq2hfvZ1RLc51NmaBBFs6TJCOtQD+aoc=;
        b=tMVOn/3J8Eu/WIkTYxlnWR3PZ1+u8HH4pAfPjuRAEnDxdqZSLvMVp1TVHdT89GHRBt
         qLG/lKeqpK4a9qPyjA1EsaST+SYFD3OAVK/nyqDhSTdyeuDPVu2etxqFuL0ZYC5PSq8p
         tLXsbLK/eJuNWtJe4+6BGpPZE5vmlVD1vti7UH6VsZs0Eueu2qBC0aFMb9qPz5pdU5Wv
         NQy5NW6UhZNRBKJ/LQO7jGQ4WiNLNTKOJpiYKWVwPXtCN4JkOSA4BhoY1Q9UesRS+6iG
         sLOhYVpbvOPDWz2FvnNEKxbtYV2A3qFd66E5xlFzI52ASnWjms9dzYivyXj8uW1Nf1P3
         Hoiw==
X-Received: by 10.66.231.69 with SMTP id te5mr8750966pac.98.1438360901017;
        Fri, 31 Jul 2015 09:41:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id fj6sm8626243pdb.21.2015.07.31.09.41.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 09:41:38 -0700 (PDT)
In-Reply-To: <1438301956-1658-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 30 Jul 2015 17:19:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275053>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> So I was trying to understand how to implement "git add .gitmodules" as 
> I intend to rewrite git submodules in C.

A request and a suggestion.

 - Please keep Jens and Heiko in the loop and pick their brains ;-)

 - It may not be the best use of your time to attempt rewriting the
   whole of "git submodule" in C in a single pass (which is the
   impression I am getting from seeing you say "git add
   .gitmodules").

   The largest pain point a rewrite in C would solve is that "git
   submodule init" and "update" have to go sequencially even though

   (1) there is no inherent reason for cloning and fetching of
       different submodules to happen in some order;

   (2) there is no inherent reason for a failure to clone or fetch
       of one submodule to abort the entire session without cloning
       or fetching other submodules; and

   (3) the operation in each submodule takes human-scale time and
       the users would benefit greatly by parallel operations.

   One approach that may be beneficial would be to introduce "git
   submodule--helper" written in C to have selected primitives used
   in "git submodule" script to speed them up.  Perhaps the first
   subcommand would be "

    $ git submodule--helper foreach-parallel --cmd=$cmd $args...

   where it takes the arguments currently fed to module_list as
   $args... and runs $cmd in parallel.  The initial implementation
   of "git submodule update" then would replace the expensive and
   sequencial

       module_list "$@" | {
           ...
           while read mode sha1 stage sm_path
           do
           	...
	   done
       }

   loop with a call to the foreach-parallel subcommand.

   The end-user scripts that currently use "git submodule foreach"
   may or may not depend on the sequencial nature of the current
   implementation, so adding "git submodule foreach-parallel" may be
   a good way to expose this as a new "do it in parallel" feature.

   Once you have a solid infrastructure to implement the helper
   subcommand "foreach-parallel" (I'd expect the interface inside C
   into that function would be to give it a worker function with the
   data for the function to consume, and the above --cmd=$cmd form
   would use a worker function that essentially does run_command();
   the spawn(2)ing and wait(2)ing would be done on the more generic
   API side), you can rewrite the $cmd part in C little by little,
   and eventually you would get a full C implemention while keeping
   everything working and retaining debuggability during the course
   of development.

Thanks.
