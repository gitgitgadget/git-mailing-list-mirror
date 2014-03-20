From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSOC 2014]idea:Git Configuration API Improvement
Date: Thu, 20 Mar 2014 10:10:23 +0100
Message-ID: <vpqd2hh5j7k.fsf@anie.imag.fr>
References: <1395300220-7540-1-git-send-email-zhaox383@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org
To: Yao Zhao <zhaox383@umn.edu>
X-From: git-owner@vger.kernel.org Thu Mar 20 10:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQZ05-0004yN-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 10:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbaCTJKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 05:10:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48409 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaCTJKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 05:10:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2K9AN2o028333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Mar 2014 10:10:23 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2K9ANBR014714;
	Thu, 20 Mar 2014 10:10:23 +0100
In-Reply-To: <1395300220-7540-1-git-send-email-zhaox383@umn.edu> (Yao Zhao's
	message of "Thu, 20 Mar 2014 02:23:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 20 Mar 2014 10:10:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2K9AN2o028333
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395911427.90472@NuBD01nmaqcgxC9GFLBTdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244526>

Hi,

Yao Zhao <zhaox383@umn.edu> writes:

> First is about when to start reading configuration file to cache. My
> idea is the time user starts call command that need configuration
> information (need to read configuration file).

I'd actually load the configuration lazily, when Git first requires a
configuration variable's value. Something like

int config_has_been_loaded = 0;

git_config() {
	if (!config_has_been_loaded) {
		load_config();
		config_has_been_loaded = 1;
	} else if (cache_is_outdated()) {
		load_config();
	} else { /* Nothing to do, we're good */ }
	do_something_with_loaded_config();
}

> Second is about data structure. I read Peff's email listed on idea
> page. He indicated two methods and I prefer syntax tree.

Why?

(In general, explaining why you chose something is more important than
explaining what you chose)

> I think there should be three or more syntax tree in the cache. One
> for system, one for global and one for local. If user indicate a file
> to be configuration file, add one more tree. Or maybe we can build one
> tree and tag every node to indicate where it belongs to.

A tree (AST, Abstract syntax tree) can be interesting if you have some
source-to-source transformations to do on the configuration files (i.e.
edit the config files themselves).

For read-only accesses, I would find it more natural to have a
data-structure that reflects the configuration variables themselves, not
the way they appear in the config file. For example, a map (hashtable)
associating to each config variable the corresponding value (which may
be a scalar value or a list, depending on the variable).

But the really important part here is the API exposed to the user, not
the internal data-structure. A map would be "more efficient" (O(1) or
O(log(n)) access), but traversing the AST for each config request would
not really harm: this is currently what we're doing, except that we
currently re-parse the file each time. OTOH, the API should hide the AST
for most uses. If the user wants the value of configuration variable
"foo", the code to do that should not be much more complex than
get_value_for_config_variable("foo"). (well, I did oversimplify a bit
here).

> Third one is about when to write back to file, I am really confused
> about it. I think one way could be when user leave git repository
> using "cd" to go back. But I am not sure if git could detect user
> calls "cd" to leave repository.

There semes to be a misunderstanding here. The point of the project is
to have a per-process cache, but Git does not normally store a state in
memory between two calls. IOW, when you run

  git status
  cd ../
  git log

The call to "git status" creates a process, but the process dies before
you run "cd". The call to "git log" is a different process. It can
re-use things that "git status" left on disk, but not in-memory data
structures.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
