From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Mon, 23 Jul 2007 18:56:09 +0800
Message-ID: <46A48949.1020501@midwinter.com>
References: <20070723041741.GA22461@midwinter.com> <Pine.LNX.4.64.0707231059490.14781@racer.site> <46A481B4.7000502@midwinter.com> <Pine.LNX.4.64.0707231136530.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICvaK-000666-JI
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbXGWK4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbXGWK4N
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:56:13 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:47582
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752828AbXGWK4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:56:12 -0400
Received: (qmail 14979 invoked from network); 23 Jul 2007 10:56:11 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=wgac7g+93sYXjIHcogA7aicNVjYCjhmnOyE0nyXWcchAQ4d5INmwZI0ezTZx63An  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 23 Jul 2007 10:56:10 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <Pine.LNX.4.64.0707231136530.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53427>

Johannes Schindelin wrote:
> Ah, I missed that.  But IIRC your patch does not wrap that logic behind 
> test ! -z "$templatefile", right?  So this is my modified suggestion:
>
> test ! -z "$templatefile" && {
> 	grep -vie '^Signed-off-by:' < "$GIT_DIR"/COMMIT_MSG" > "$GIT_DIR"/tmp1
> 	grep -ve '^#' < "$templatefile" > "$GIT_DIR"/tmp1
> 	trap 'rm "$GIT_DIR"/tmp[12]' 0
> 	cmp "$GIT_DIR"/tmp[12] &&
> 	die "Unchanged message; will not commit"
> }
>   

So you are suggesting I do this in addition to the existing git-commit 
stripping of Signed-off-by: lines? I can certainly do that, but I didn't 
want to make two passes over the commit message doing exactly the same 
stripping.

Hmm, maybe I should outline my understanding of the current (unpatched) 
behavior and what I want it to do. Currently:

* Strip off all comment lines (happens when COMMIT_MSG is created)
* Strip off all Signed-off-by: lines
* Trim whitespace
* If the result has no content (`wc -l` == 0), abort.

With the patch, my intent was:

* Strip off all comment lines
* Strip off all Signed-off-by: lines
* Trim whitespace
* If the result has no content (! -s file), abort.
* If a template file was specified:
   * Strip off all comment and Signed-off-by: lines from the template
   * Trim whitespace from the template
   * If the resulting trimmed template is the same as the trimmed commit 
message, abort.

So I guess before getting to the specifics of the code, I'll ask: does 
the above make sense as a design? I wanted to preserve the existing 
behavior in the absence of a template.

Since the existing code is already stripping Signed-off-by: lines to 
test for a zero-length commit message, I figured I should reuse that 
work. However, it's no big deal to do it twice if people feel that 
results in more readable code -- certainly no human will ever notice the 
time it takes to re-grep the commit message.

-Steve
