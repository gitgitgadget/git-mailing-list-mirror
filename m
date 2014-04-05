From: Lewis Diamond <git@lewisdiamond.com>
Subject: The fetch command should "always" honor remote.<name>.fetch
Date: Sat, 05 Apr 2014 18:43:41 -0400
Message-ID: <5340871D.8070503@lewisdiamond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 00:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWZJy-0005Eb-EP
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 00:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbaDEWno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 18:43:44 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:56703 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbaDEWnn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 18:43:43 -0400
Received: by mail-ie0-f172.google.com with SMTP id as1so4826127iec.31
        for <git@vger.kernel.org>; Sat, 05 Apr 2014 15:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=zTXi15Z2+ZrUgczfcE9SHV7cjZKjqP+mocr5VflOXWM=;
        b=AcKU7N8rYPNb1h5irldaDvj3HPkkt8xzPmVQ3x5UXl4Mcfeq5YfcPLvHxRkUuWVWe2
         bQbUOC/2AYta5h85FM7EypfMk9YaSYahXglUG9rPpbvbyiI2DQ9Zcn3ciDRNEceasexU
         2zNQ8AuO3MAVrskdrk1Z903IW660X4ndfhAwPjYM/qmH/+2bo3JXc5MeVUjIM0/F6VrM
         9XkDwnm4w6hA3tIBCPXQrKfwhH/78djE2czLjEyszCapKOqQ8m7wqQPDW1wtTRgQqTJ5
         IJr7eEAoFEe1bj63NTCi50Us8n0WBTGnAWGZ7XHdqYDN3dUMslDcbAwEm/SrEuf/1mTv
         b5JQ==
X-Gm-Message-State: ALoCoQnvYbVk/RFEX7nZCAYTIwqajWQlgdm7Yz5JhKPVVDxQkW/oRIrMFQqlz+35YOtGRELGArbN
X-Received: by 10.42.120.15 with SMTP id d15mr19650482icr.35.1396737822682;
        Sat, 05 Apr 2014 15:43:42 -0700 (PDT)
Received: from [192.168.1.140] (MTRLPQ4362W-LP130-05-1279561823.dsl.bell.ca. [76.68.144.95])
        by mx.google.com with ESMTPSA id u1sm17151117igm.8.2014.04.05.15.43.41
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Apr 2014 15:43:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245786>

Hi all,
//for tldr; see EOM
I recently setup git for my team and we ran into a small annoyance. 
Though this may be solved with a simple alias, I decided to spend this 
Saturday afternoon exploring the Git source to find out how easy an 
actual patch could be. Unfortunately, the fix isn't trivial and I'm not 
familiar with the Git code base. I'd definitely prefer fixing issue 
properly in the source since the behaviour is, in my opinion, 
inconsistent, so I'll need some insights from experienced git developers.

Let me first describe the issue. Within a single repository, multiple 
ref name spaces can be defined to hold, for example, user branches. For 
example, the main development branches can be located under 
refs/heads/[master | develop] while users push their personal branches 
to refs/user/[bob | alice]/heads/* in order to save their work or 
collaborate with one another. The problem arises when fetching from 
configured fetch refspecs. The behaviour isn't consistent with the push 
behaviour. Let's look at an example:

==
Alice has a repository with a configured remote named foo:
[remote "foo"]
     url = ...
     fetch = +refs/heads/*:refs/remotes/foo/*
     fetch = +refs/users/bob/heads/*:refs/remotes/foo/bob/
     p
     push = refs/heads/*:refs/users/alice/heads/*

Let's say the following refs exist on the remote:
refs/heads/master
refs/users/bob/heads/master
refs/users/bob/heads/develop

If Alice has a master and feature_a branch, 'git push foo' would result in:
master -> refs/users/alice/heads/master
feature_a -> refs/users/alice/heads/feature/a

'git push foo feature/a' would result in:
feature/a -> refs/users/alice/heads/feature/a

'git fetch foo' would result in:
[new ref] refs/users/bob/heads/master -> foo/bob/master //OK
[new ref] refs/users/bob/heads/develop -> foo/bob/develop //OK
[new ref] refs/heads/master -> foo/master //OK

'git fetch foo refs/users/bob/heads/develop' would result in (FETCH_HEAD 
omitted):
[new ref] refs/users/bob/heads/develop -> foo/bob/develop //OK

'git fetch foo refs/heads/master' would result in (FETCH_HEAD omitted):
[new ref] refs/heads/master -> foo/master //OK

'git fetch foo develop' would result in:
fatal: Couldn't find remote ref test2 //Not OK, (case 1)

'git fetch foo master' would result in (FETCH_HEAD omitted):
[new ref] refs/heads/master -> foo/master //OK, but missing another ref! 
(case 2)
//It should also fetch refs/users/bob/heads/master -> foo/bob/master

If you remove this configuration line: fetch = 
+refs/heads/*:refs/remotes/foo/*
Then you run 'git fetch foo master', this would result in:
  * branch master -> FETCH_HEAD //Debatable whether this is OK or not, 
but it's definitely missing bob's master! (case 3)
==

case 1: The ref abbreviation is received in builtin/fetch.c: get_ref_map 
and passed to remote.c:get_fetch_map with missing_ok = 0. The 
abbreviated ref is then evaluated through remote.c:get_remote_ref --> 
remote.c:find_ref_by_name_abbrev to finally end up being matched in 
refs.c:ref_rev_parse_rules. Since in this case, develop doesn't exist 
under 'develop', 'refs/develop', 'refs/tags/develop', 
'refs/heads/develop', 'refs/remotes/develop' or 
'refs/remotes/develop/HEAD', no ref is matched and the command dies (due 
to missing_ok=0). All of this happens without ever looking at the 
configured fetch refspec.

case 2: Starts like case 1, except that the ref_rev_parse_rules get a 
match and only this match is used. The destination is then mapped in a 
later call to get_fetch_map, from builtin/fetch.c@311

case 3: Same as 2, but it maps to HEAD.

tldr;
In my opinion, these issues can be resolved with the following rules:
1. Explicit refs (starts with refs/) are fetched 'as-is' and put into 
FETCH_HEAD and into every configured refspec->dst for which refspec->src 
matches the input ref. (The push command should be made the same for 
consistency. It currently only pushes to the first matching refspec.)
2. Abbreviated refs (e.g. 'master') are matched only against the 
remote_refs matching remote->fetch_refspec (I think remote.c 
get_expanded_map can provide this). If multiple matches exist, all of 
them are fetched to their corresponding refspec->dst (and FETCH_HEAD). 
If multiple matches exist and have conflicting refspec->dst, error out 
(or should we honour the first matching refspec?).

Note that for the 2nd rule, if remote->fetch_refspec doesn't include 
refs/heads/*, it means I went through the trouble of removing it from 
the configuration. Therefore, I think it shouldn't even be fetched. 
However, we need to make sure to handle 'git fetch <URL> master', such 
that it is still evaluated by ref_rev_parse_rules.

Any input is be appreciated.
Thanks,
Lewis Diamond
