From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Sun, 27 Jul 2008 19:50:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 19:52:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNAPo-0002vY-TI
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 19:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYG0RvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 13:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYG0RvP
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 13:51:15 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:2417 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbYG0RvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 13:51:14 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6RHoutR031201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Jul 2008 19:51:03 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90348>

Hi,

On Sat, 26 Jul 2008, Linus Torvalds wrote:

> > Is there a way to change that default?
> 
> Use an alias or something.

This doesn't help with the graphical front ends and they only use what git 
gives them.

> To see why it's the default, do a few tests. In particular, try it with 
> gitk on the kernel. Try it on some fairly simple file that doesn't get a 
> lot of churn. Example:
> 
> 	gitk lib/vsprintf.c
> 
> vs
> 
> 	gitk --full-history lib/vsprintf.c
> 
> and if you don't _immediately_ see why --full-history isn't the default, 
> there's likely something wrong with you. One is useful. The other is not.
> 
> So we absolutely _have_ to simplify merges. There is no question about it.

Well, I don't want that much history.
Let's take a different example. Look at kernel/sched_rt.c with git-log, 
--full-history shows an extra commit of a patch which was committed and 
merged twice, but there is no information how this other patch was merged. 
If you have giggle installed, you'll see that commit as a loose end.

(I have git version 1.5.6.2 installed in case it matters.)

> That said, we currently simplify merges the simple and stupid way, and 
> I've hinted several times on this mailing list that there is a better way 
> to do it (last time it was the discussion about "filter-branch".
> 
> In fact, if you google for 
> 
> 	filter-branch full-history
> 
> you'll find some of the discussion. In order to make --full-history useful 
> as a default, we'd need to do an after-the-fact merge cleanup (ie remove 
> lines of development that are later found to really be totally 
> uninteresting), but that is *hard*.

I played a little with it in the ruby script below, which produces a 
complete connected graph of all content nodes and which have been merged 
into the head, e.g. for sched_rt.c it produces that extra commit merge. 
The script basically eliminates all empty merges. As input to the script I 
used "git log --parents --name-only --full-history kernel/sched_rt.c | 
grep -e ^commit -e ^kernel", which seems to produce the same amount of 
commits as "gitk --full-history ...".

The main function is to check, whether one parent of a commit is an 
ancestor of another parent, so that this path can be eliminated. I tried 
it with other paths and too simple implementations quickly lead to 
exponential behaviour. :) It probably also shouldn't be recursive, I had 
to increase the stack limit, otherwise I got stack exceptions.
Otherwise it seems to work fine, it wasn't that hard :-)

The ruby syntax shouldn't be too hard too read, the nonobvious thing is 
maybe that '$' marks global variables.

bye, Roman


#! /usr/bin/ruby

$parent = Hash.new
$content = Hash.new
$result = Hash.new

commit = nil
head = nil
while l = $stdin.gets
	a = l.split(" ")
	if a[0] == "commit"
		commit = a[1]
		head = commit unless head
		$parent[commit] = a[2..-1]
	else
		$content[commit] = true
	end
end

$parent_check = Hash.new
$parent_cache = Hash.new

def commit_has_parent?(commit, commit2)
	if $parent_check[commit]
		print "parent loop for #{commit} (#{commit2})?\n"
		p $parent_check
		return false
	end
	return $parent_cache[commit] if $parent_cache.has_key?(commit)
	$parent_check[commit] = true
	res = false
	if $content[commit] > $content[commit2]
		$parent[commit].each do |parent|
			if parent == commit2 || commit_has_parent?(parent, commit2)
				res = true
				break;
			end
		end
	end
	$parent_cache[commit] = res
	$parent_check.delete(commit)
	$parent_cache.clear if $parent_check.empty?
	return res
end

def check_commit(commit)
	return $result[commit] if $result.has_key? commit
	a = Array.new
	$parent[commit].each do |parent|
		parent = check_commit(parent)
		if parent
			a.each_index do |i|
				if a[i] == parent || commit_has_parent?(a[i], parent)
					parent = nil
					break
				elsif commit_has_parent?(parent, a[i])
					a[i] = parent
					parent = nil
					break
				end
			end
		end
		a.push(parent) if parent
	end
	$parent[commit] = a
	$content[commit] = true if a.size > 1
	if $content[commit]
		$result[commit] = commit
		max = 1
		a.each do |parent|
			max = $content[parent] + 1 if max <= $content[parent]
		end
		$content[commit] = max
	else
		$result[commit] = a[0]
	end
	return $result[commit]
end

check_commit(head)
#p $result
#p $parent

p $content.keys.size
$content.each_key do |commit|
	p [ commit, $parent[commit] ]
	commit = $parent[commit][0]
end
