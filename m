From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv15 0/5] Expose submodule parallelism to the user
Date: Tue, 23 Feb 2016 19:20:12 -0800
Message-ID: <1456284017-26141-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 24 04:22:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYQ1p-0006ay-80
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 04:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbcBXDWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 22:22:12 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35639 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbcBXDWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 22:22:11 -0500
Received: by mail-pf0-f175.google.com with SMTP id c10so4493762pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 19:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MvTOwx0GZ7MWIdZxyt37rp9tmwODfVOiBlvn+5gbTj4=;
        b=AJo1Qhriru81h6+QVxJGcxsUM/RyHLMIGNsQeaTKUjuQnFvWV3mUVzXtgwFVgBwGG0
         ycSMND+l+uKEky8e/ROop3gPoWL25tv1IiTzGVqTHS872MZP72i9yFLOfPsOloOnJC9r
         pZEKv8BQyJzG/4A+CLC47xxWlMa1sCSD4fjaOh/04FZRr6WIUyBCDPw494UUswoelPXO
         /Y0dEbnwd133V744xj/e1ytpICOLQhQfwzZKcMvW7JOrQM3Idap2jYsbPmUV6efGsJZ8
         R8bEAPDOnnTgPq5c6/XgjrTmadDREuhVKCHGacJv5AniyDmurDN8vmALuQwiWjA6vgGQ
         8qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MvTOwx0GZ7MWIdZxyt37rp9tmwODfVOiBlvn+5gbTj4=;
        b=OXwcqRdX3jjLVls+hVN6ERgv0zD6FhLrckxjiA1PT8YCPgigz3poN2Vyp8dWglVptv
         wBPCI3or+iKvId0JSGp6GveUxXBpHD33vF3vr6ilsOQbmniakaBvOFE2YiTG1mKo0iFX
         8nzKwnUAAkjuw68zfpEcGnlIa8+/OizWEeskxFPnnovWpTcYT+cDNA9a96PCANnz3SsQ
         yB5ZP+Gzo6qyZzBiP92BlAsFeJvw0l4ji3lQex5MZkd8PQHIunPGYCQVEEfidsOHpPqe
         ueRHppDoCOBx7WsKpcTJGjzcUztLD4jYjRcKpabVhERK6mi5jpXK/i9ImopyoK2AAz0P
         fQiw==
X-Gm-Message-State: AG10YORZncDCoGQVU6ZzZZvvYxtAcyaZgqrxCa0YJw5C7q59FVnk9zO1QoqXw47kE6MbadjE
X-Received: by 10.98.79.156 with SMTP id f28mr51444613pfj.55.1456284130524;
        Tue, 23 Feb 2016 19:22:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a8b2:5b44:5b58:45af])
        by smtp.gmail.com with ESMTPSA id tp6sm725584pab.25.2016.02.23.19.22.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Feb 2016 19:22:08 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287164>

This build on top of 163b9b1f919c762a4bfb693b3aa05ef1aa627fee
(origin/sb/submodule-parallel-update~3) and replaces the commits 
origin/sb/submodule-parallel-update~2.. 

* Renamed inspect_clone_next_submodule to prepare_to_clone_next_submodule
  and reordered the arguments thereof
* Comments for the struct submodule_update_clone which is passed around
* Better handling around LFs.
* Renamed struct child_process *cp to *child
* Print #unmatched in git-submodule.sh instead of the helper

> 
> 	if (pp->update.type == SM_UPDATE_NONE
> 	    || (pp->update.type == SM_UPDATE_UNSPECIFIED
> 	        && sub->update_strategy.type == SM_UPDATE_NONE)) {
> 
> What does pp stand for?

I think I took it as parallel_process when starting off from the parallel
processing machinery. I'll rename it (probably to suc as short for struct
submodule_update_clone).

> > +	if (pp->recursive_prefix)
> > +		displaypath = relative_path(pp->recursive_prefix,
> > +					    ce->name, &displaypath_sb);
> 
> Nit: could use braces.

Why? I would understand a few lines above where we have an if nested in an
if with braces. But here we have a pretty straighforward one statement per case
condition.


> > +	sub = submodule_from_path(null_sha1, ce->name);
> 
> It's common to call submodule_from_path with null_sha1 as a parameter
> but I have trouble continuing to remember what that means.  Maybe
> there should be a separate function that handles that?  As a
> side-effect, the name and docstring of that function could explain
> what it means, which I still am not sure about. :)

I'll do that as a followup cleanup patch as it affects more than just the
new code.

>> +		OPT_STRING(0, "reference", &pp.reference, "<repository>",
>> +			   N_("Use the local reference repository "
>> +			      "instead of a full clone")),

> Is this allowed to be relative?  If so, what is it relative to?

It is passing on the argument to clone, so I assume the same rules apply as for
git-clone.

Thanks,
Stefan

Stefan Beller (5):
  run-command: expose default_{start_failure, task_finished}
  run_processes_parallel: add LF when caller is sloppy
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 ++-
 builtin/submodule--helper.c     | 255 +++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh                |  56 ++++-----
 run-command.c                   |  35 ++++--
 run-command.h                   |  19 +++
 t/t0061-run-command.sh          |  26 ++++
 t/t7406-submodule-update.sh     |  27 +++++
 test-run-command.c              |  18 +++
 10 files changed, 412 insertions(+), 56 deletions(-)

-- 
2.7.0.rc0.34.ga06e0b3.dirty
