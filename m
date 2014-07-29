From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC] GSoC status update (config API improvements)
Date: Tue, 29 Jul 2014 18:28:18 +0530
Message-ID: <53D79A6A.2090302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC716-0008Ct-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbaG2NAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 09:00:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:44873 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaG2NAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:00:12 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so1288652pab.40
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=wuUpeokicBOzDeb4lURHoO91MVgoY+5pUe/qixuK180=;
        b=cD90LmnuCtDESo5yD1ZuxPV36YIXqFordLcRc6xLVwIJ5O1izcVqQWut57I1cmShwc
         FKQdi5GZkmnMj5EgXTay6/bpqyROyMO58CMMeWUn6svI75ce4t6Ye2qHIbNJZ5v4HfCA
         CVGyhX5NAxsRu8cjYAs562Het8ZZH6EiTyHMJiuNm22jOQogz18A6ILqkdLHNU4iKcRI
         cE9lO/UHSXOyjeclu+Vo7YdbMPoichQiVSo524GPW/JB13yyItN92QRqQwzWbXuflwrV
         oGcbKZaUZpB/wbKY4S2AaWhh5nBO+eU3F23EBVMqVtO+/rAbUJ2tdW1YiA7Cq6URXn2n
         CjMw==
X-Received: by 10.68.213.34 with SMTP id np2mr1808142pbc.167.1406638811746;
        Tue, 29 Jul 2014 06:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([223.184.138.24])
        by mx.google.com with ESMTPSA id g7sm28852981pdk.87.2014.07.29.05.58.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 05:58:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254427>

One month to go for GSoC to end and I am almost at the end of my project.
So what have we accomplished do far? Let's see,

1> Git config cache:

I have written a config cache which reads and caches the key/value pairs
in a hashmap. It is generalized as config-set which can also be used to read
config-like files (for example submodule config files).

Instead of the unwieldy git_config() callback process for querying, callers
can now use the new API to query config values in as straightforward manner.

for example, for querying "foo.frotz", we can just write,

	char *value;
	git_config_get_value("foo.frotz", &value);

Similar to git_config_get_value() there are helpers which do conversion to the
desired type (int or bool) as well as querying.

It is already in pu as "ta/config-set" and its latest iteration can be found
on [1].

2> git_config() now uses the caching layer underneath.

git_config() now uses the config-set API, thus preventing expensive rereads
of the configuration files during a git invocation.

It's almost polished and ready for pu. The latest iteration can be found on [2].

3> git_config() calls rewrites

Most of the git_config() calls in the code base can be rewritten as one liners using
the new config-set API.

Work has already started on it and can be seen on [3].

4> Tidy git configuration files

To be honest, I haven't started any real work on it, except brainstorming on it
for a little while. Basically it aims to correct the two broken tests in
t1300-repo-config.sh, caused by the deficiencies in git_config_set() which are,
section headers are left untouched, even when all the keys related to it have been
unset and adding a key into an empty section reuses the header .

5> Any new feature suggestions??

Other than the above, new features can be built on top of the new API.
Going through the previous mailing lists I could find one or two ideas, namely,

a> Unsetting previously set values
Local config files can be used to unset config values previously set in system
files. The user may not have the privilege to touch the system files so he can
leverage the new API to unset the previously set values.

Any suggestions for new features or improvements are welcome!

Also, I like to thank my mentors Matthieu and Ram for their suggestions
and timely review even when my patches were late. ;)

Cheers,
Tanay Abhra.

[1]:http://thread.gmane.org/gmane.comp.version-control.git/254286
[2]:http://thread.gmane.org/gmane.comp.version-control.git/254412
[3]:http://thread.gmane.org/gmane.comp.version-control.git/253948
