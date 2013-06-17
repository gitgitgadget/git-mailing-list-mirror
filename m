From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC] speed up git submodule
Date: Mon, 17 Jun 2013 02:05:03 +0200
Message-ID: <1371427503-9678-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Mon Jun 17 02:02:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoMtf-0004TF-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 02:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab3FQABx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 20:01:53 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:62528 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab3FQABx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 20:01:53 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so1931401lab.17
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=1pbLi/fEGPQFRqcBgUp/nB0NZ/hQm4rhr7/Z/aMoyrY=;
        b=Qn8F4jM8zSKQqAk605ZyGdOJLE91zFM4ahDLiK3Uvhqk1DlMjEo+wKvDsqwZRf79j9
         spp6EJBtCIBOMdKap1AeRYs5EqTt/ecOCHtyMt+WGyUiYeXPaDWNgNDGWyEIKy+UKkzq
         gf32ioik/xkf78xa8dyn3zEGqqPWfVQP96aftGEiZnHu9QIr7i009dNFKNjPvFdQYWTC
         B5MunSgqRVAVWpy7oXsX0aQj9VHdqxcUJI7yYH0yVP9dO0AOQP20adrF88R7a8O/GHK0
         7FdJS1xHAQzOxjZCa4PDWMk0jTV6VoF8TmtZiX5UHMG8MYZGYO892ZJN+fEXQ4a1gJ1v
         Ki2g==
X-Received: by 10.112.146.33 with SMTP id sz1mr5313615lbb.47.1371427310989;
        Sun, 16 Jun 2013 17:01:50 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id o5sm1734765lag.2.2013.06.16.17.01.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 17:01:50 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UoMwc-0002Wj-BG; Mon, 17 Jun 2013 02:05:14 +0200
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228031>

I've been playing a bit with lua. It's an embedded scripting language
with strong c integration. It's small and fast.

The interesting feature would be to run C-functions direct inside lua. I
suppose that would increase speed even more, at the same time as we have
the convinence of a interpreted language. Lua is smaller and faster
(well as always, it depends on what you're doing) than python and ruby.
Perl is a really pain for the windows folks (I've heard).

A correct implementation for lua support would be to start a
lua-interpreter from inside git.c (or somewhere) and load the lua code
for a specific command. That would make us independent of any target
installation of lua (althought the git binary would increase with the
lua library around 300 kb).

However I did a quick test using lua as a replacement for sh (without
direct calls to c-functions) and the result is impressive. (However this
is the wrong way of using lua, shell scripting is not something lua is
good at).

I did some runs on a project with 52 submodules (or 53 if you count the
ones in .gitmodules). These results are pretty typical:
iveqy@kolya:~/projects/eracle_core$ time /home/iveqy/projects/git/git-submodule.lua > /dev/null

real    0m1.665s
user    0m0.276s
sys     0m0.452s
iveqy@kolya:~/projects/eracle_core$ time git submodule > /dev/null

real    0m3.413s
user    0m0.476s
sys     0m1.224s

For me, that speedup does matter.

NOTICE!!!
This code is experimental. It does have some known bugs, it does have
some style issues. A state of the art complete implementation would
contain a few more tests/jumps and less concat (which is extremely
expensive in lua) and less git-invokation.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.lua | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 git-submodule.lua

diff --git a/git-submodule.lua b/git-submodule.lua
new file mode 100755
index 0000000..14f71e6
--- /dev/null
+++ b/git-submodule.lua
@@ -0,0 +1,104 @@
+#!/usr/bin/lua
+
+function run_cmd(cmd)
+	local f = io.popen(cmd, 'r');
+	local out = f:read('*a');
+	f:close()
+	return out
+end
+
+function fwrite(fmt, ...)
+	return io.write(string.format(fmt, ...))
+end
+
+function read_gitmodules()
+	local inf = assert(io.open('.gitmodules', 'r'))
+	local config = inf:read("*all")
+	gitmodules = {}
+	for sm in string.gmatch(config, '%[[^]]*%][^%[]*') do
+		local thismod = {}
+		local name = string.match(sm, '%[%s-submodule%s-"(.+)"%s-%]')
+		thismod["name"] = name
+		local path = ''
+		for k, v in string.gmatch(sm, '\n%s*([^=^%s]*)%s*=%s*([^\n]*)') do
+			if k == 'path' then
+				path = v
+			else
+				thismod[k] = v
+			end
+		end
+		if path == '' then
+			fwrite("No path found for %s in .gitmodules\n", name)
+			os.exit(1)
+		end
+		gitmodules[path] = thismod
+	end
+
+	return gitmodules
+end
+
+function module_list()
+	local lsfiles = 'git ls-files --stage --error-unmatch -z || echo "#unmatched"'
+	local out = run_cmd(lsfiles)
+	local unmerged = ''
+	local subs = read_gitmodules()
+
+	for row in string.gmatch(out, '.-\0') do
+		if row == '#unmatched' then
+			os.exit(1)
+		end
+
+		local mode, sha1, stage, path = string.match(row, '(%d+)%s([0-9a-f]+)%s(.)%s(.*)\0')
+		if mode == '160000' then
+			if stage == '0' then
+				subs[path]["sha1"] = sha1
+				subs[path]["stage"] = stage
+			else
+				if unmerged ~= path then
+					local null_sha1 = '0000000000000000000000000000000000000000'
+					subs[path]["sha1"] = null_sha1
+					subs[path]["stage"] = 'U'
+				end
+				unmerged = path
+			end
+		end
+	end
+	return subs
+end
+
+function get_name_rev(path, sha1)
+	if sha1 == nil then sha1="" end
+	local cmd = "cd \"" .. path .. "\" && (git describe " .. sha1 ..
+				" 2>/dev/null || git describe --tags " .. sha1 ..
+				" 2>/dev/null || git describe --contains " .. sha1 ..
+				" 2>/dev/null || git describe --all --always " .. sha1 ..
+				" 2>/dev/null) "
+	return string.gsub(run_cmd(cmd), '\n', '')
+end
+
+function cmd_status()
+	subs = module_list()
+	for smpath in pairs(subs) do
+		if (subs[smpath].sha1) then
+			if subs[smpath].stage == 'U' then
+				subs[smpath]["revname"] = get_name_rev(smpath, subs[smpath].sha1)
+				fwrite("U%s %s (%s)", subs[smpath].sha1, smpath, subs[smpath].revname)
+			elseif run_cmd("test -z " .. subs[smpath].url .. " || ! test -d " .. smpath .."/.git -o -f " .. smpath .. "/.git || echo '0' ") ~= '0\n' then
+				subs[smpath]["revname"] = get_name_rev(smpath, subs[smpath].sha1)
+				fwrite("-%s %s (%s)\n", subs[smpath].sha1, smpath, subs[smpath].revname)
+			elseif run_cmd("git diff-files --ignore-submodules=dirty --quiet -- " .. smpath .. " || echo '0'") ~= '0\n' then
+				p = run_cmd("git diff-files --ignore-submodules=dirty --quiet -- " .. smpath .. " || echo '0'")
+				subs[smpath]["revname"] = get_name_rev(smpath, subs[smpath].sha1)
+				fwrite(" %s %s (%s)\n", subs[smpath].sha1, smpath, subs[smpath].revname)
+			else
+				subs[smpath].sha1 = string.gsub(run_cmd('cd ' .. smpath .. ' && git rev-parse --verify HEAD'), "\n", "")
+				subs[smpath]["revname"] = get_name_rev(smpath, subs[smpath].sha1)
+				fwrite("+%s %s (%s)\n", subs[smpath].sha1, smpath, subs[smpath].revname)
+			end
+		end
+	end
+end
+
+if arg[1] == nil or arg[1] == 'status' then
+	cmd_status()
+end
-- 
1.8.3.1.381.g2ab719e.dirty
