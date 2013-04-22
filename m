From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] remote-hg: allow refs with spaces
Date: Mon, 22 Apr 2013 15:32:35 -0700
Message-ID: <7v61zenqm4.fsf@alter.siamese.dyndns.org>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
	<1366667724-567-14-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPHy-0002PD-0N
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab3DVWcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:32:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab3DVWcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:32:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59CB9183D5;
	Mon, 22 Apr 2013 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZzVBnuNpwW95WsfnNWkurPnds+0=; b=r1ZswY
	Yvln2YqiFAajSEdkXQSnASNrqQO8DNP0IVOwANzoLKQGC3oYRsU1zpef1Ntj8rSM
	8Tu4bM55fisMbYNdqvaW/fgGZ7N782P4z1UjYIo1w2S4PUkr3FuBRaUP6StqYsG8
	BANX7/39+/RuD5hgB3tZdMV51hMbFq5/Nh2IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vz4LXp7BFher0ilT7HmnP8RppbXguaEg
	W29APyUkdoM4hUp32dZqZ8zP8zIbACn8ElRKcDc3/7D2+lEXyIgOn24vDfMqOmy2
	7XQ94Hr9xRRi8ISsNqTg7SS50q92g+00xDCnX0Vqf8x+D9+BrSW2QxnB7FJTxSPR
	/Itl2fXyAvw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5131C183D4;
	Mon, 22 Apr 2013 22:32:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2E2E183D2;
	Mon, 22 Apr 2013 22:32:36 +0000 (UTC)
In-Reply-To: <1366667724-567-14-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 22 Apr 2013 16:55:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 886F3A60-AB9C-11E2-A744-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222120>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Mercurial supports them, Git doesn't.

Another important thing to note is that you represent a SP with
three underscores on our side, no?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index dbb4091..6f4afd7 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -75,6 +75,12 @@ def hgmode(mode):
>  def hghex(node):
>      return hg.node.hex(node)
>  
> +def hgref(ref):
> +    return ref.replace('___', ' ')
> +
> +def gitref(ref):
> +    return ref.replace(' ', '___')
> +
>  def get_config(config):
>      cmd = ['git', 'config', '--get', config]
>      process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
> @@ -437,10 +443,10 @@ def export_ref(repo, name, kind, head):
>      marks.set_tip(ename, rev)
>  
>  def export_tag(repo, tag):
> -    export_ref(repo, tag, 'tags', repo[tag])
> +    export_ref(repo, tag, 'tags', repo[hgref(tag)])
>  
>  def export_bookmark(repo, bmark):
> -    head = bmarks[bmark]
> +    head = bmarks[hgref(bmark)]
>      export_ref(repo, bmark, 'bookmarks', head)
>  
>  def export_branch(repo, branch):
> @@ -479,14 +485,14 @@ def branch_tip(repo, branch):
>  def get_branch_tip(repo, branch):
>      global branches
>  
> -    heads = branches.get(branch, None)
> +    heads = branches.get(hgref(branch), None)
>      if not heads:
>          return None
>  
>      # verify there's only one head
>      if (len(heads) > 1):
>          warn("Branch '%s' has more than one head, consider merging" % branch)
> -        return branch_tip(repo, branch)
> +        return branch_tip(repo, hgref(branch))
>  
>      return heads[0]
>  
> @@ -508,6 +514,7 @@ def list_head(repo, cur):
>              head = 'master'
>          bmarks[head] = node
>  
> +    head = gitref(head)
>      print "@refs/heads/%s HEAD" % head
>      g_head = (head, node)
>  
> @@ -529,15 +536,15 @@ def do_list(parser):
>                  branches[branch] = heads
>  
>          for branch in branches:
> -            print "? refs/heads/branches/%s" % branch
> +            print "? refs/heads/branches/%s" % gitref(branch)
>  
>      for bmark in bmarks:
> -        print "? refs/heads/%s" % bmark
> +        print "? refs/heads/%s" % gitref(bmark)
>  
>      for tag, node in repo.tagslist():
>          if tag == 'tip':
>              continue
> -        print "? refs/tags/%s" % tag
> +        print "? refs/tags/%s" % gitref(tag)
>  
>      print
>  
> @@ -674,7 +681,8 @@ def parse_commit(parser):
>  
>      # Check if the ref is supposed to be a named branch
>      if ref.startswith('refs/heads/branches/'):
> -        extra['branch'] = ref[len('refs/heads/branches/'):]
> +        branch = ref[len('refs/heads/branches/'):]
> +        extra['branch'] = hgref(branch)
>  
>      if mode == 'hg':
>          i = data.find('\n--HG--\n')
> @@ -803,6 +811,7 @@ def do_export(parser):
>              continue
>          elif ref.startswith('refs/tags/'):
>              tag = ref[len('refs/tags/'):]
> +            tag = hgref(tag)
>              author, msg = parsed_tags.get(tag, (None, None))
>              if mode == 'git':
>                  if not msg:
