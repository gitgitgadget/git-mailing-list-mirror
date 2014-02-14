From: Dario Bertini <berdario@gmail.com>
Subject: diff weirdness (bug?)
Date: Fri, 14 Feb 2014 20:20:04 +0100
Message-ID: <52FE6C64.4060700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 20:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOJ9-0005hS-RA
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbaBNTUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:20:13 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:40767 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbaBNTUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 14:20:11 -0500
Received: by mail-ee0-f54.google.com with SMTP id e53so5906842eek.13
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 11:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=EggvnB0z9MbRYibrfDfOGvsQ/8N52p5YEwCppVaOv30=;
        b=m99wp7SB2Gu5a2wfNIgtOHRDwDjf6eKBkaw3AjN9FHsNW942ErvF2j0Ol9AC6uSJ5c
         9d+lOqLPgZSKZ57cF69XAhYOtFESiYsgpZ1HLl4xWHWxFK2GqvSDrV+uwq0tWyxkGjGI
         Pu+LqOEw/9tbT49gB4N7bGfj8DgC2mo5fVWaKQqKwWw8dYdhtoGH1lvMVlx2aJ6Vir4j
         WdJ5PFw1PQlKK7xm95zGgc8p0DFebtJKAUITEmWaZ6vcy/jy45r+KQDKy1Y074/+eD54
         prEAUCFYyk1wGsYUMeOBRP8kvSMVjDZPNK/uzxLBOjQa40VlCYM5WhAZKMDROAJqqG/x
         7/nw==
X-Received: by 10.14.174.193 with SMTP id x41mr1419944eel.87.1392405609764;
        Fri, 14 Feb 2014 11:20:09 -0800 (PST)
Received: from [192.168.1.34] (host245-76-dynamic.21-79-r.retail.telecomitalia.it. [79.21.76.245])
        by mx.google.com with ESMTPSA id m1sm23091241een.7.2014.02.14.11.20.06
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 11:20:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242124>

git clone git@github.com:ansible/ansible.git
git revert 3616dffb68badb2b8d56

manually solve the conflict (you can look at the commit here:
https://github.com/ansible/ansible/commit/3616dffb68badb2b8d56ef34391d7aae8de79cd6
)

git diff will output:

dario@macbook ~/P/ansible (devel*+|REVERTING)> git diff
diff --cc lib/ansible/constants.py
index c055ccf,6eac602..0000000
--- a/lib/ansible/constants.py
+++ b/lib/ansible/constants.py
@@@ -84,16 -61,8 +84,12 @@@ active_user   = pwd.getpwuid(os.geteuid

  # Needed so the RPM can call setup.py and have modules land in the
  # correct location. See #1277 for discussion
- if getattr(sys, "real_prefix", None):
-     # in a virtualenv
-     DIST_MODULE_PATH = os.path.join(sys.prefix, 'share/ansible/')
- else:
-     DIST_MODULE_PATH = '/usr/share/ansible/'
+ DIST_MODULE_PATH = os.path.join(sys.prefix, 'share/ansible/')

 +# check all of these extensions when looking for yaml files for things
like
 +# group variables
 +YAML_FILENAME_EXTENSIONS = [ "", ".yml", ".yaml" ]
 +
  # sections in config file
  DEFAULTS='defaults'



now, it weirdly/incorrectly says that we added the YAML-related lines

if we remove these 3 lines, we'll get this diff:

dario@macbook ~/P/ansible (devel*+|REVERTING)> git diff --patience
diff --cc lib/ansible/constants.py
index c055ccf,6eac602..0000000
--- a/lib/ansible/constants.py
+++ b/lib/ansible/constants.py
@@@ -84,16 -61,8 +84,9 @@@ active_user   = pwd.getpwuid(os.geteuid

  # Needed so the RPM can call setup.py and have modules land in the
  # correct location. See #1277 for discussion
- if getattr(sys, "real_prefix", None):
-     # in a virtualenv
-     DIST_MODULE_PATH = os.path.join(sys.prefix, 'share/ansible/')
- else:
-     DIST_MODULE_PATH = '/usr/share/ansible/'
+ DIST_MODULE_PATH = os.path.join(sys.prefix, 'share/ansible/')

- # check all of these extensions when looking for yaml files for things
like
- # group variables
- YAML_FILENAME_EXTENSIONS = [ "", ".yml", ".yaml" ]
 +
  # sections in config file
  DEFAULTS='defaults'


even more weirdly, it'll say that we deleted the yaml-related lines

if we also remove one of the extra blank lines next to the yaml lines we
get an empty diff:

dario@macbook ~/P/ansible (devel*+|REVERTING)> git diff
diff --cc lib/ansible/constants.py
index c055ccf,6eac602..0000000
--- a/lib/ansible/constants.py
+++ b/lib/ansible/constants.py


running `git add .` and then checking with git diff --cached will show
that everything is normal

the output is the same also with
git diff --minimal
or
git diff --patience


-- 
xmpp: berdario@gmail.com
bitmessage: BM-2cTYXfGiSTsnx3righ6aHcJSWe4MV17jDP
gpg fingerprint: 3F8D53518012716C4EEF7DF67B498306B3BF75A0 (used just
for signing commits)
