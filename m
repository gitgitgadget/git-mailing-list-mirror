From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Mon, 04 Feb 2013 12:04:55 +0100
Message-ID: <510F95D7.6010107@drmicha.warpmail.net>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 12:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2JrS-0003l4-1N
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 12:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab3BDLEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 06:04:55 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41017 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751660Ab3BDLEy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 06:04:54 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D2529209F1;
	Mon,  4 Feb 2013 06:04:53 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 04 Feb 2013 06:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qg6TefT1pPChVhmalYuKyj
	3NjWc=; b=BOaxow0AYK9ax+YtlnqzVScgmnprH7wdgqVdWaWaI7DQefprwucCvB
	FlPcGGYKfeWTI2aerTvg72fbe+SS0A96jA3pvLYVHoXM4SZa1mbWHjGBuX0Xj9Se
	80DUVUlPORQYNoYW4ELi58DM2PKmtRlUHEZw/Z9kBXFPEVNI0hsSQ=
X-Sasl-enc: rYFelgAj+3vQp7mge10PoEFCuDXv1u2+LflQQLXiSnyI 1359975893
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 58CC08E0924;
	Mon,  4 Feb 2013 06:04:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215374>

Junio C Hamano venit, vidit, dixit 04.02.2013 00:10:
> I think a natural way to ask reviewing the recent merges while
> showing tricky ones would be to say:
> 
> 	$ git log --first-parent --cc master..pu
> 
> But this does not to show what I expect to see, which is an output
> of:
> 
> 	$ git log --first-parent --cc -p master..pu
> 

I'm not Junio, but I guess he would respond that it's a matter of
expectations: "--cc" is a diff option, and just like any other diff
option, it has an effect on "log" only if "log" has been told to show a
diff.

Oh wait, you *are* Junio ;)

> This is only a minor irritation, but I think it might make sense to
> make it notice the --cc in the former and turn -p on automatically.

I think we have a clear distiction between rev-list/log options and diff
options. "log" comes without a diff, "-p" turns on diffs.

"log" passes diff-options to "diff". If the user gives a diff-option to
"log" we can conclude that he meant to request a diff and turn them on
automatically (as if "-p" was there also).

But I'm wondering whether that has adverse effects on scripts/aliases.
For example, I could have a special alias

newpu = log first-parent --cc next..pu

which allows me to use "git newpu" as well as "git newpu -p" to get
those new commits with or without diff in my preferred format, but not
any more after the change you suggest. (I could use a second alias, of
course; and yes, I'm (ab)using current option parser features.)

> The same for
> 
> 	$ git log --cc next~3..next
> 
> which may make sense to turn into "git log -p --cc next~3..next".
> 
> When deciding if the above makes sense, there are a few things to
> know to be true as prerequisites for the discussion:
> 
>  * Neither of these
> 
> 	$ git log --first-parent -p master..pu
> 	$ git log -p master..pu
> 
>    shows any patches, and it is not a bug.  No patches are shown for
>    merges unless -m is given, and when -m is given, we give pairwise
>    2-way diffs for the number of parents.

But diffs are on here ("-p"), it's just that the default diff option for
merges is to not display them. Well, I admit there's two different ways
of thinking here:

A) "git log -p" turns on diffs for all commits, and the default diff
options is the (non-existing) "--no-show" diff-option for merges.

B) "git log -p" applies "-p" to all commits except merge commits.

I'm strongly in the A camp, because I think that this gives a clearer
interface. A really describes the user facing side, whereas B is closer
to the implementation.

>  * We recently tweaked this:
> 
> 	$ git log --first-parent -m -p master..pu
> 
>    to omit diffs with second and later parents, as that is what the
>    user wishes with --first-parent.

That made --first-parent into a dual-purpose option, i.e. it modifies
the rev-listing to one parent as well as the diff creation. It does not
turn on diffs by itself.

>  * The "--cc" option, when comparing two trees (i.e. showing a
>    non-merge commit), is designed to show a normal patch.  In other
>    words, you can view "--cc" as a modifier when you request a patch
>    output format with "-p".  For "git show", "--cc -p" is turned on
>    by default, and giving "-m" explicity (i.e. "git show -m") you
>    can turn it off and have it do "-m -p" instead.
> 

Yes, I really think of --cc is a diff-option, and that this point of
view gives the clearest ui.

We could argue that any diff-option could switch on diffs (imply -p),
but that change seems to be quite radical. "show" having "-p" as a
default is quite natural, but that is different.

Having only "--cc" imply "-p" would be too much special case auto-magic
for my taste. We have too many of these already.

I really think we should leave it as is.

Michael
