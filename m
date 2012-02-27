From: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
Subject: Re: [PATCH 1/2] builtin/symbolic-ref.c: add option to fall back to
 normal ref
Date: Mon, 27 Feb 2012 23:40:37 +0100
Message-ID: <4F4C0665.6000103@jk.gs>
References: <1330380536-9647-1-git-send-email-jk@jk.gs> <7v1upf6hp5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 23:45:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S29Jl-0005CX-Kz
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab2B0WpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 17:45:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:35362 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755784Ab2B0WpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 17:45:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S29JX-00055d-0I
	for git@vger.kernel.org; Mon, 27 Feb 2012 23:45:03 +0100
Received: from xdsl-89-0-11-50.netcologne.de ([89.0.11.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 23:45:02 +0100
Received: from jk by xdsl-89-0-11-50.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 23:45:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-89-0-11-50.netcologne.de
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7v1upf6hp5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191688>

On 02/27/2012 11:21 PM, Junio C Hamano wrote:
> What is "the current value of HEAD"?

Well, essentially it contains a "type" and a "value". The type is either
"symbolic" or "not symbolic" and the value is a ref if HEAD is currently
symbolic or a SHA1 otherwise.

These definitions don't come from the glossary, obviously. It's just the
way I interpret HEAD. If you think the patch would be better off with a
different wording, I'd be happy for suggestions.

In any case, if you have the "value" without the "type", you can
actually derive the "type" from the "value": if it has the shape of a
SHA1, it was a direct ref; otherwise it was a symbolic ref (unless the
user has a ref that looks like a SHA1 but in that case some other tools
do funny things, too).

> The symbolic-ref command is there for people who _care_ about the
> distinction between a HEAD that points at a branch and a HEAD that points
> directly at a commit.  There is no room for the command to "fall back"
> anywhere, as that will only introduce an unnecessary ambiguity to the
> command whose sole purpose is to be able to tell them apart.

That's why it's an optional thing.

> If the caller does not need to know if the HEAD is detached or not, and
> wants to know what commit it points at, why is it insufficient to just use
> rev-parse, e.g. "git rev-parse --verify HEAD"?

The use case here is having one convenient command to remember what is
currently checked out, and being able to go back to that later. "git
checkout" will do the right thing if you just give it "master" or a
complete SHA1, so all we need to remember is that.

"git rev-parse --verify HEAD" will only give us the SHA1, even if HEAD
isn't actually detached.

Incidentally, the -s switch in the second patch makes this even easier:

    OLDHEAD=`git symbolic-ref -s -f HEAD`
    # do stuff here that involves switching branches or detaching or
    # whatever
    git checkout $OLDHEAD

Without these patches, the shortest way I can think of to do the same
thing would be:

    OLDHEAD=`git rev-parse --symbolic-full-name HEAD`
    [ "$OLDHEAD" = "HEAD" ] && OLDHEAD=`git rev-parse HEAD`
    # ...

-Jan
