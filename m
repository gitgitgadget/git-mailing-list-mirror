From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 14:32:01 -0400
Message-ID: <4FFF1821.7030705@windriver.com>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com> <7vhatcc1ql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:32:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpOBS-0004dJ-Ma
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 20:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934203Ab2GLScK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 14:32:10 -0400
Received: from mail.windriver.com ([147.11.1.11]:64591 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877Ab2GLScH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 14:32:07 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q6CIW2nQ014980
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 12 Jul 2012 11:32:02 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Thu, 12 Jul 2012
 11:32:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vhatcc1ql.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201373>

On 12-07-12 01:45 PM, Junio C Hamano wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> If git am wasn't run with --reject, we assume the end user
>> knows where to find the patch.  This is normally true for
>> a single patch,
> 
> Not at all.  Whether it is a single or broken, the patch is fed to
> underlying "apply" from an unadvertised place.

What I meant by this was the difference between:

	git am 0001-some-standalone-single.patch
vs.
	git am mbox

In the 1st, the standalone patch is 100% clear and easy to access,
because we really don't need/care about the unadvertised place.

Maybe I should have said "knows how to get at the single patch"?

> 
>> So, provide a helpful hint as to where they can
>> find the patch ...
> 
> This is OK, but you may want to give a way to squelch it once the
> user learns where it is by following the usual "advice.*" thing.
> 
>> ... to do the manual fixup before eventually
>> continuing with "git add ... ; git am -r".
> 
> This is _NOT_ fine, especially if you suggest "patch" the user may
> not have, and more importantly does not have a clue why "git apply"
> rejected it ("am" does _not_ use "patch" at all).

I'm not 100% sure I'm following what part here is not OK.  If you
can help me understand that, I'll respin the change accordingly.

Is it the assumption that the user will have the patch
command in /usr/bin not OK, or that the message implies that
git is somehow using /usr/bin/patch is not OK?

In case it helps any, a brief summary of my workflow is this:

git am /tmp/mbox
<some random fail halfway in the queue>
patch -p1 --dry-run < .git/rebase-apply/patch
# gauge status.  Is patch really invalid, or already applied?
# already applied; "git am --skip"
# no, if valid, but with minor issues, apply what we can.
patch -p1 < .git/rebase-apply/patch
# manually deal with rejects (typically with wiggle)
git add any_new_files
git add -u
git am -r

Paul.
--

> 
> 
