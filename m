From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] remote-hg: store converted URL
Date: Tue, 15 Jan 2013 18:46:22 +0100
Message-ID: <1C0B25E7-40B2-46AC-B730-1EBDC8A82B7C@quendi.de>
References: <1357760618-81222-1-git-send-email-max@quendi.de> <7vmwwbd43o.fsf@alter.siamese.dyndns.org> <64C81CD0-960A-47F2-89FC-8D3126B1F4D5@quendi.de> <7vzk0a4ekj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:46:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvAb2-0004ik-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 18:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab3AORq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 12:46:28 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:36211 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753305Ab3AORq1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 12:46:27 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TvAac-0006ew-LZ; Tue, 15 Jan 2013 18:46:22 +0100
In-Reply-To: <7vzk0a4ekj.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358271987;2664a1d3;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213655>


On 15.01.2013, at 17:05, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>> On 14.01.2013, at 19:14, Junio C Hamano wrote:
>> 
>>> What is lacking from this description is why it even needs to work
>>> from a different working directory....
> 
> In your rewrite below, this is still lacking, I think.

Hm, I thought I made it clear: It has to change because relative paths only make sense when you know the reference point they are relative with.

Typically. This is the pwd. But when I 

  git clone repo newrepo
  cd newrepo

I just changed the PWD. The clone command was given the relative path "repo". If git were to use that, it would suddenly refer to a directory inside newrepo, not next to it. Bang. Hence, git expands the relative path to an absolute one in the above example.

But git cannot do that for URLs in the form HELPER::PATH, because such a string is necessarily opaque to git.

<snip>

>> Thus when latter attempting to, say, "git pull"
>> from inside gitrepo, remote-hg cannot resolve the relative path correctly,
>> and the user sees an unexpected error.
> 
> ... "cannot resolve the relative path correctly" above sound like a
> bug in remote-hg.  Something like:
> 
>    Cloning a local hg repository using a relative path, e.g.
> 
>      git clone hg::hgrepo gitrepo
> 
>    stores "hg::hgrepo" in gitrepo/.git/config as its URL.  When
>    remote-hg is invoked by "git fetch", it chdirs to X (which is
>    different from the "gitrepo" directory) and uses the URL (which
>    is not correct, as it is a relative path but the cwd is
>    different when it is used) to interact with the original
>    "hgrepo", which will fail.
> 
> is needed, but you didn't explain what that X is.  Perhaps it is a
> temporary directory.  Perhaps it is a hidden Hg repository somewhere
> in gitrepo/.git directory.  Or something else.

None of the above. Nor does the remote helper chdir anywhere. It is the user who has done the chdir: Away from the location he invoked "git clone" at, and into the new repository directory that previously did not even exist.



Cheers,
Max