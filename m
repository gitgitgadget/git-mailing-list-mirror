From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/6] Make stgit.config use git-repo-config.
Date: Sat, 27 Jan 2007 18:22:33 +0100
Message-ID: <20070127172233.27183.7071.stgit@gandelf.nowhere.earth>
References: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArHT-00032T-Bs
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbXA0RXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXA0RXz
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:23:55 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:46461 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbXA0RXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:23:53 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 9E9EE5523;
	Sat, 27 Jan 2007 18:23:51 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 6065F1F089;
	Sat, 27 Jan 2007 18:22:33 +0100 (CET)
In-Reply-To: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37970>


This is an initial implementation without any sort of caching.  If we
want that, we could do it with this new API.  We could even just
simply generalize the use of ConfigOption instead.

I just copypasted __run from stgit.git to avoid too much work, but
it's definitely something to cleanup.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py  |    5 +
 stgit/commands/mail.py    |   27 +++-----
 stgit/commands/pull.py    |    9 +--
 stgit/commands/refresh.py |    2 -
 stgit/config.py           |  154 ++++++++++++++++++++++-----------------------
 stgit/git.py              |   10 +--
 stgit/gitmergeonefile.py  |    7 +-
 stgit/stack.py            |    5 +
 8 files changed, 104 insertions(+), 115 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 2e57824..432edce 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -311,9 +311,10 @@ def address_or_alias(addr_str):
         if addr.find('@') >= 0:
             # it's an e-mail address
             return addr
-        if config.has_option('mail "alias"', addr):
+        alias = config.get('mail.alias.'+addr)
+        if alias:
             # it's an alias
-            return config.get('mail "alias"', addr)
+            return alias
 
         raise CmdException, 'unknown e-mail alias: %s' % addr
 
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 6f61b83..236b519 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -129,9 +129,8 @@ def __get_sender():
     """Return the 'authname <authemail>' string as read from the
     configuration file
     """
-    if config.has_option('stgit', 'sender'):
-        sender = config.get('stgit', 'sender')
-    else:
+    sender=config.get('stgit.sender')
+    if not sender:
         try:
             sender = str(git.user())
         except git.GitException:
@@ -207,9 +206,8 @@ def __build_address_headers(msg, options, extra_cc = []):
     cc_addr = ''
     bcc_addr = ''
 
-    if config.has_option('stgit', 'autobcc'):
-        autobcc = config.get('stgit', 'autobcc')
-    else:
+    autobcc = config.get('stgit.autobcc')
+    if not autobcc:
         autobcc = ''
 
     if options.to:
@@ -283,8 +281,9 @@ def __edit_message(msg):
     f.close()
 
     # the editor
-    if config.has_option('stgit', 'editor'):
-        editor = config.get('stgit', 'editor')
+    editor = config.get('stgit.editor')
+    if editor:
+        pass
     elif 'EDITOR' in os.environ:
         editor = os.environ['EDITOR']
     else:
@@ -469,14 +468,10 @@ def func(parser, options, args):
     """Send the patches by e-mail using the patchmail.tmpl file as
     a template
     """
-    smtpserver = config.get('stgit', 'smtpserver')
+    smtpserver = config.get('stgit.smtpserver')
 
-    smtpuser = None
-    smtppassword = None
-    if config.has_option('stgit', 'smtpuser'):
-        smtpuser = config.get('stgit', 'smtpuser')
-    if config.has_option('stgit', 'smtppassword'):
-        smtppassword = config.get('stgit', 'smtppassword')
+    smtpuser = config.get('stgit.smtpuser')
+    smtppassword = config.get('stgit.smtppassword')
 
     applied = crt_series.get_applied()
 
@@ -511,7 +506,7 @@ def func(parser, options, args):
     if options.sleep != None:
         sleep = options.sleep
     else:
-        sleep = config.getint('stgit', 'smtpdelay')
+        sleep = config.getint('stgit.smtpdelay')
 
     # send the cover message (if any)
     if options.cover or options.edit_cover:
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 7c5db22..15ed636 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -53,10 +53,8 @@ def func(parser, options, args):
     if len(args) >= 1:
         repository = args[0]
     else:
-        section = 'branch "%s"' % git.get_head_file()
-        if config.has_option(section, 'remote'):
-            repository = config.get(section, 'remote')
-        else:
+        repository = config.get('branch.%s.remote' % git.get_head_file())
+        if not repository:
             repository = 'origin'
 
     refspec = None
@@ -88,8 +86,7 @@ def func(parser, options, args):
         push_patches(applied, options.merged)
 
     # maybe tidy up
-    repack = config.get('stgit', 'keepoptimized')
-    if repack == 'yes':
+    if config.get('stgit.keepoptimized') == 'yes':
         git.repack()
 
     print_crt_patch()
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 0efe1df..7a9bf7d 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -77,7 +77,7 @@ options = [make_option('-f', '--force',
 
 
 def func(parser, options, args):
-    autoresolved = config.get('stgit', 'autoresolved')
+    autoresolved = config.get('stgit.autoresolved')
 
     if autoresolved != 'yes':
         check_conflicts()
diff --git a/stgit/config.py b/stgit/config.py
index f5fbdab..c2d413b 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -18,90 +18,86 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import os, ConfigParser
-from StringIO import StringIO
+import os
 from stgit import basedir
 
-config = ConfigParser.RawConfigParser()
-
-def git_config(filename):
-    """Open a git config file and convert it to be understood by
-    Python."""
-    try:
-        f = file(filename)
-        cont = False
-        lines = []
-        for line in f:
-            line = line.strip()
-
-            if cont:
-                # continued line, add a space at the beginning
-                line = ' ' + line
-
-            if line and line[-1] == '\\':
-                line = line[:-1].rstrip()
-                cont = True
-            else:
-                line = line + '\n'
-                cont = False
-
-            lines.append(line)
-
-        f.close()
-        cfg_str = ''.join(lines)
-    except IOError:
-        cfg_str = ''
-
-    strio = StringIO(cfg_str)
-    strio.name = filename
-
-    return strio
+class GitConfigException(Exception):
+    pass
+
+class GitConfig:
+    __defaults={
+        'stgit.autoresolved':	'no',
+        'stgit.smtpserver':		'localhost:25',
+        'stgit.smtpdelay':		'5',
+        'stgit.pullcmd':		'git-pull',
+        'stgit.merger':		'diff3 -L current -L ancestor -L patched -m -E ' \
+				'"%(branch1)s" "%(ancestor)s" "%(branch2)s" > "%(output)s"',
+        'stgit.autoimerge':		'no',
+        'stgit.keeporig':		'yes',
+        'stgit.keepoptimized':	'no',
+        'stgit.extensions':		'.ancestor .current .patched',
+        }
+
+    def __run(self, cmd, args=None):
+        """__run: runs cmd using spawnvp.
+    
+        Runs cmd using spawnvp.  The shell is avoided so it won't mess up
+        our arguments.  If args is very large, the command is run multiple
+        times; args is split xargs style: cmd is passed on each
+        invocation.  Unlike xargs, returns immediately if any non-zero
+        return code is received.  
+        """
+        
+        args_l=cmd.split()
+        if args is None:
+            args = []
+        for i in range(0, len(args)+1, 100):
+            r=os.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i+100, len(args))])
+        if r:
+            return r
+        return 0
+    
+    def get(self, name):
+        stream = os.popen('git repo-config --get %s' % name, 'r')
+        value = stream.readline().strip()
+        stream.close()
+        if len(value) > 0:
+            return value
+#         elif found in mergeonefile:
+#             XXX
+        elif (self.__defaults.has_key(name)):
+            return self.__defaults[name]
+        else:
+            return None
+
+    def getall(self, name):
+        stream = os.popen('git repo-config --get-all %s' % name, 'r')
+        values = [line.strip() for line in stream]
+        stream.close()
+#        if len(values)==0 and found in mergeonefile:
+#             XXX
+        return values
+
+    def getint(self, name):
+        value = self.get(name)
+        if value.isdigit():
+            return int(value)
+        else:
+            raise GitConfigException, 'Value for "%s" is not an integer: "%s"' % (name, value)
+
+    def set(self, name, value):
+        self.__run('git-repo-config', [name, value])
+
+config=GitConfig()
 
 def config_setup():
     global config
 
-    # Set the defaults
-    config.add_section('stgit')
-    config.set('stgit', 'autoresolved', 'no')
-    config.set('stgit', 'smtpserver', 'localhost:25')
-    config.set('stgit', 'smtpdelay', '5')
-    config.set('stgit', 'pullcmd', 'git-pull')
-    config.set('stgit', 'merger',
-               'diff3 -L current -L ancestor -L patched -m -E ' \
-               '"%(branch1)s" "%(ancestor)s" "%(branch2)s" > "%(output)s"')
-    config.set('stgit', 'autoimerge', 'no')
-    config.set('stgit', 'keeporig', 'yes')
-    config.set('stgit', 'keepoptimized', 'no')
-    config.set('stgit', 'extensions', '.ancestor .current .patched')
-
-    # Read the configuration files (if any) and override the default settings
-    # stgitrc are read for backward compatibility
-    config.read('/etc/stgitrc')
-    config.read(os.path.expanduser('~/.stgitrc'))
-    config.read(os.path.join(basedir.get(), 'stgitrc'))
-
-    # GIT configuration files can have a [stgit] section
-    try:
-        global_config = os.environ['GIT_CONFIG']
-    except KeyError:
-        global_config = os.path.expanduser('~/.gitconfig')
-    try:
-        local_config = os.environ['GIT_CONFIG_LOCAL']
-    except KeyError:
-        local_config = os.path.join(basedir.get(), 'config')
-    config.readfp(git_config(global_config))
-    config.readfp(git_config(local_config))
-
     # Set the PAGER environment to the config value (if any)
-    if config.has_option('stgit', 'pager'):
-        os.environ['PAGER'] = config.get('stgit', 'pager')
-
-    # [gitmergeonefile] section is deprecated. In case it exists copy the
-    # options/values to the [stgit] one
-    if config.has_section('gitmergeonefile'):
-        for option, value in config.items('gitmergeonefile'):
-            config.set('stgit', option, value)
-
+    pager = config.get('stgit.pager')
+    if pager:
+        os.environ['PAGER'] = pager
+    # FIXME: handle EDITOR the same way ?
 
 class ConfigOption:
     """Delayed cached reading of a configuration option.
@@ -113,7 +109,7 @@ class ConfigOption:
 
     def __str__(self):
         if not self.__value:
-            self.__value = config.get(self.__section, self.__option)
+            self.__value = config.get(self.__section + '.' + self.__option)
         return self.__value
 
 
@@ -126,7 +122,7 @@ def file_extensions():
     global __extensions
 
     if not __extensions:
-        cfg_ext = config.get('stgit', 'extensions').split()
+        cfg_ext = config.get('stgit.extensions').split()
         if len(cfg_ext) != 3:
             raise CmdException, '"extensions" configuration error'
 
diff --git a/stgit/git.py b/stgit/git.py
index 4c5685a..c21c074 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -449,10 +449,10 @@ def user():
     """
     global __user
     if not __user:
-        if config.has_option('user', 'name') \
-               and config.has_option('user', 'email'):
-            __user = Person(config.get('user', 'name'),
-                            config.get('user', 'email'))
+        name=config.get('user.name')
+        email=config.get('user.email')
+        if name and email:
+            __user = Person(name, email)
         else:
             raise GitException, 'unknown user details'
     return __user;
@@ -816,7 +816,7 @@ def pull(repository = 'origin', refspec = None):
     if refspec:
         args.append(refspec)
 
-    if __run(config.get('stgit', 'pullcmd'), args) != 0:
+    if __run(config.get('stgit.pullcmd'), args) != 0:
         raise GitException, 'Failed "git-pull %s"' % repository
 
 def repack():
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index 587c8c4..b9d02aa 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -102,9 +102,8 @@ def interactive_merge(filename):
     """Run the interactive merger on the given file. Note that the
     index should not have any conflicts.
     """
-    try:
-        imerger = config.get('stgit', 'imerger')
-    except Exception, err:
+    imerger = config.get('stgit.imerger')
+    if not imerger:
         raise GitMergeException, 'Configuration error: %s' % err
 
     extensions = file_extensions()
@@ -185,7 +184,7 @@ def merge(orig_hash, file1_hash, file2_hash,
                     os.system('git-update-index --cacheinfo %s %s %s'
                               % (file1_mode, file1_hash, path))
 
-                    if config.get('stgit', 'autoimerge') == 'yes':
+                    if config.get('stgit.autoimerge') == 'yes':
                         print >> sys.stderr, \
                               'Trying the interactive merge'
                         try:
diff --git a/stgit/stack.py b/stgit/stack.py
index 2ae4dd5..087403f 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -92,8 +92,9 @@ def edit_file(series, line, comment, show_patch = True):
     f.close()
 
     # the editor
-    if config.has_option('stgit', 'editor'):
-        editor = config.get('stgit', 'editor')
+    editor = config.get('stgit.editor')
+    if editor:
+        pass
     elif 'EDITOR' in os.environ:
         editor = os.environ['EDITOR']
     else:
