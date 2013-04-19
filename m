From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 01/11] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 14:38:42 -0500
Message-ID: <CAMP44s0H-2nafJiV33_6xPH2WzT+=c0ULGg8XqB-mHOc2cHomg@mail.gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
	<1366399831-5964-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:38:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH8z-0001jv-80
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab3DSTip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:38:45 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33138 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3DSTio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:38:44 -0400
Received: by mail-la0-f53.google.com with SMTP id eg20so32428lab.40
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CzBGdfA/Al1C7qQmXzkN8JPFMM1+6a/LCUng/Ux9ues=;
        b=EYjEYG0P5rYtYSG2UozyWADBNieA0gyBv5sX1v5MHXMDMydOb077vUX0dr8r/VNuDO
         XjLRt1WImfPlHgL+R0p8QPrqgZ5deeLpPvIODv312rfVQDxFmRQDt5fWeuCqShoro/Gl
         vA9NgOFYZvaY8og+3oAX8hWWnrJTL6v5IjkFLX0gg9Z8l04TgXKq1Mstfy8/JmnyJhaW
         eI4BLL5ss/t6wPkOuYNWFarIXZ6AUHhkW0eMEj/tcHgSc2HtXAyLUtn293VzKt9K6Mz9
         3vBrE6kg6foTB+eWFrlJ5C27bB7imf5f0XAXkFVt/ICt+VgPeS5IeiJeIbZRZKsPcc6Q
         pP8A==
X-Received: by 10.112.22.198 with SMTP id g6mr4712113lbf.135.1366400322868;
 Fri, 19 Apr 2013 12:38:42 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 19 Apr 2013 12:38:42 -0700 (PDT)
In-Reply-To: <1366399831-5964-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221809>

On Fri, Apr 19, 2013 at 2:30 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This script find people that might be interesting in a patch, by going
> back through the history for each single hunk modified, and finding
> people that reviewed, acknowledge, signed, or authored the code the
> patch is modifying.
>
> It does this by running 'git blame' incrementally on each hunk, and then
> parsing the commit message. After gathering all the relevant people, it
> groups them to show what exactly was their role when the participated in
> the development of the relevant commit, and on how many relevant commits
> they participated. They are only displayed if they pass a minimum
> threshold of participation.
>
> For example:
>
>   % git cc-cmd 0001-remote-hg-trivial-cleanups.patch
>   Felipe Contreras <felipe.contreras@gmail.com> (author: 100%)
>   Jeff King <peff@peff.net> (signer: 83%)
>   Max Horn <max@quendi.de> (signer: 16%)
>   Junio C Hamano <gitster@pobox.com> (signer: 16%)
>
> Thus it can be used for 'git send-email' as a cc-cmd.

Here's the interdiff with the previous one:

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index c7ecf79..aa83a1a 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -5,40 +5,35 @@ $min_percent = 5

 class Commit

-  attr_reader :id
-  attr_accessor :roles
+  attr_reader :id, :roles

   def initialize(id)
     @id = id
     @roles = []
   end

-  def self.parse(data)
-    id = author = msg = nil
+  def parse(data)
+    author = msg = nil
     roles = {}
     data.each_line do |line|
       if not msg
         case line
-        when /^commit (.+)$/
-          id = $1
         when /^author ([^<>]+) <(\S+)>$/
           author = $1, $2
-          roles[author] = 'author'
+          roles[author] = :author
         when /^$/
           msg = true
         end
       else
         if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
           person = $2, $3
-          roles[person] = 'signer' if person != author
+          roles[person] = :signer if person != author
         end
       end
     end
-    roles = roles.map do |person, role|
-      address = "%s <%s>" % person
+    @roles = roles.map do |person, role|
       [person, role]
     end
-    [id, roles]
   end

 end
@@ -57,22 +52,15 @@ class Commits

   def import
     return if @items.empty?
-    format = [ 'commit %H', 'author %an <%ae>', '', '%B' ].join('%n')
-    File.popen(['git', 'show', '-z', '-s', '--format=format:' +
format] + @items.keys) do |p|
-      p.each("\0") do |data|
-        next if data == "\0" # bug in git show?
-        id, roles = Commit.parse(data)
-        commit = @items[id]
-        commit.roles = roles
-      end
-    end
-  end
-
-  def each_person_role
-    commit_roles = @items.values.map { |commit| commit.roles }.flatten(1)
-    commit_roles.group_by { |person, role| person }.each do |person,
commit_roles|
-      commit_roles.group_by { |person, role| role }.each do |role,
commit_roles|
-        yield person, role, commit_roles.size
+    File.popen(%w[git cat-file --batch], 'r+') do |p|
+      p.write(@items.keys.join("\n"))
+      p.close_write
+      p.each do |l|
+        if l =~ /^(\h{40}) commit (\d+)/
+          id, len = $1, $2
+          data = p.read($2.to_i)
+          @items[id].parse(data)
+        end
       end
     end
   end
@@ -107,34 +95,37 @@ class Commits
         end
       end
     end
-    import
   end

 end

 exit 1 if ARGV.size != 1

-commits = Commits.new()
+commits = Commits.new
 commits.from_patch(ARGV[0])
+commits.import

 # hash of hashes
 persons = Hash.new { |hash, key| hash[key] = {} }

-commits.each_person_role do |person, role, count|
-  persons[person][role] = count
+commits.items.values.each do |commit|
+  commit.roles.each do |person, role|
+    persons[person][role] ||= 0
+    persons[person][role] += 1
+  end
 end

 persons.each do |person, roles|
   roles = roles.map do |role, count|
     percent = count.to_f * 100 / commits.size
     next if percent < $min_percent
-    "%s: %u%%" % [role, percent]
+    '%s: %u%%' % [role, percent]
   end.compact
   next if roles.empty?

   name, email = person
   # must quote chars?
   name = '"%s"' % name if name =~ /[^\w \-]/i
-  person = name ? "%s <%s>" % [name, email] : email
-  puts "%s (%s)" % [person, roles.join(', ')]
+  person = name ? '%s <%s>' % [name, email] : email
+  puts '%s (%s)' % [person, roles.join(', ')]
 end

-- 
Felipe Contreras
