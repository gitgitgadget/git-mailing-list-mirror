From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] remote-hg: store converted URL
Date: Tue, 15 Jan 2013 12:41:44 +0100
Message-ID: <64C81CD0-960A-47F2-89FC-8D3126B1F4D5@quendi.de>
References: <1357760618-81222-1-git-send-email-max@quendi.de> <7vmwwbd43o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 12:42:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv4uE-0005KD-7K
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 12:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab3AOLlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 06:41:52 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:35871 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756901Ab3AOLlv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 06:41:51 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Tv4tk-0006Dj-Ng; Tue, 15 Jan 2013 12:41:44 +0100
In-Reply-To: <7vmwwbd43o.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358250111;6577fda2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213630>


On 14.01.2013, at 19:14, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>> From: Felipe Contreras <felipe.contreras@gmail.com>
>> 
>> Mercurial might convert the URL to something more appropriate, like an
>> absolute path.
> 
> "What it is converted *TO*" is fairly clear with ", like an ...",
> but from the first reading it was unclear to me "what it is
> converted *FROM*" and "*WHEN* the conversion happens".  Do you mean
> that the user gives "git clone" an URL "../hg-repo" via the command
> line (e.g. the argument to "git clone" is spelled something like
> "hg::../hg-repo"), and that "../hg-repo" is rewritten to something
> else (an absolute path, e.g. "/srv/project/hg-repo")?

Yes, that was meant. 

> 
>> Lets store that instead of the original URL, which won't
>> work from a different working directory if it's relative.
> 
> What is lacking from this description is why it even needs to work
> from a different working directory.  I am guessing that remote-hg
> later creates a hidden Hg repository or something in a different
> place and still tries to use the URL to interact with the upstream,
> and that is what breaks, but with only the above description without
> looking at your original report, people who will read the "git log"
> output and find this change will not be able to tell why this was
> needed, I am afraid.
> 
> Of course, the above guess of mine may even be wrong, but then that
> is yet another reason that the log needs to explain the change
> better.

Fully agreed. How about this commit message:

-- >8 --
remote-hg: store converted URL of hg repo in git config

When remote-hg is invoked, read the remote repository URL from the git config,
give Mercurial a chance to expand it, and if changed, store it back into
the git config.

This fixes the following problem: Suppose you clone a local hg repository
using a relative path, e.g.
  git clone hg::hgrepo gitrepo
This stores "hg::hgrepo" in gitrepo/.git/config. However, no information
about the PWD is stored, making it impossible to correctly interpret the
relative path later on. Thus when latter attempting to, say, "git pull"
from inside gitrepo, remote-hg cannot resolve the relative path correctly,
and the user sees an unexpected error.

With this commit, the URL "hg::hgrepo" gets expanded (during cloning,
but also during any other remote operation) and the resulting absolute
URL (e.g. "hg::/abspath/hgrepo") is stored in gitrepo/.git/config.
Thus the git clone of hgrepo becomes usable.
-- >8 --

> 
>> Suggested-by: Max Horn <max@quendi.de>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> Signed-off-by: Max Horn <max@quendi.de>
>> ---
>> For a discussion of the problem, see also
>>  http://article.gmane.org/gmane.comp.version-control.git/210250
> 
> I do not see any discussion; only your problem report.

Aha, an english language issue on my side I guess: For me, a single person can "discuss" a problem (often, a research paper is said to be "discussing a problem"). Sorry for that. Anyway, the reason I gave that link was because it attempts explains the problem and one solution (which this patch ended up implementing), but also express that I feel a bit uncomfortable with this. Which I still do. Relying on the remote helper to invoke "git config" feels like a hack and I was wondering whether this is deemed an acceptable solution -- or whether one should instead extend the remote-helper protocol, allowing the remote helper to signal a rewritten remote URL (perhaps only directly after a clone?). As it is, the remote helper seems (?) to have no way to distinguish whether it is being called duri
 ng a clone or a pull; hence it has to "expand" and rewrite the URL every time it is called, just in case.


Anyway, as long as this particular command works somehow, I am fine:

  git clone hg::../relative/path/to/hg-repo  git-repo


> Was this work done outside the list?  I just want to make sure this
> patch is not something Felipe did not want to sign off for whatever
> reason but you are passing it to the list as a patch signed off by
> him.

The work was done by Felipe's and published in his github repository:
  https://github.com/felipec/git/commit/605bad5b52d2fcf3d8f5fd782a87d7c97d1b040a
See also the discussion (yeah, this time a real one ;-) leading to this:
  https://github.com/felipec/git/issues/2

I took his sign-off from there and interpreted it as saying that Felipe was OK with this being pushed to git.git. But perhaps this is not what I should have done? In that case I am very sorry :-(. It's just that I feel this patch is quite useful and important for daily use (which is why I suggested it in the first place ;-), so I was/am quite eager to see it in.

Cheers,
Max


PS: recently, yet another tool has (re)emerged for using hg repos from inside git:
  https://github.com/buchuki/gitifyhg
This is partially based on Felipe's work, but has several bug fixes atop that. It is also seems to be a priority for its author, so it os more actively developed... anyway, that's now, what, "solution" #5 or #6? I really hope the dust on this will settle soon and we'll have just one (or maybe two) tools doing a decent job, instead of attention splitting over so many different ones...
