From: Andreas Ericsson <ae@op5.se>
Subject: Re: new platform & S_IFGITLINK problem
Date: Tue, 04 May 2010 08:13:44 +0200
Message-ID: <4BDFBB18.70800@op5.se>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk> <7vfx2b2ft5.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org> <alpine.LFD.2.00.1005032042470.5478@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alan Hourihane <alanh@fairlite.co.uk>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 04 08:14:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9BOL-0002fW-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 08:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab0EDGN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 02:13:56 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55608 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753924Ab0EDGNz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 02:13:55 -0400
Received: from source ([72.14.220.155]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS9+7G2kXmNExdI9T5tKre3bYsXe4r/VM@postini.com; Mon, 03 May 2010 23:13:55 PDT
Received: by fg-out-1718.google.com with SMTP id e12so855610fga.11
        for <git@vger.kernel.org>; Mon, 03 May 2010 23:13:47 -0700 (PDT)
Received: by 10.87.19.37 with SMTP id w37mr12096277fgi.25.1272953627049;
        Mon, 03 May 2010 23:13:47 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d8sm16686829fga.26.2010.05.03.23.13.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 23:13:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <alpine.LFD.2.00.1005032042470.5478@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146296>

On 05/04/2010 05:52 AM, Linus Torvalds wrote:
> 
> 
> On Mon, 3 May 2010, Linus Torvalds wrote:
>> On Sat, 1 May 2010, Junio C Hamano wrote:
>>>
>>>   (3) write MODE_SYSTEM_TO_GIT() macro to convert from S_IF{REG,DIR,LNK} we
>>>       read from struct stat to the "canonical" GIT_S_IF{REG,DIR,LNK}
>>>       values; and
>>>
>>>   (4) change all the code that read mode from struct stat and use it to
>>>       first use MODE_SYSTEM_TO_GIT().
>>>
>>> Currently 'git grep -e "S_IF[A-Z]" -e "struct stat"' reports around 250
>>> hits, so it is not infeasible amount of work, but it is not a trivial and
>>> mechanical replacement, either.  I or somebody need to set aside a block
>>> of time to do this clean-up and audit the result.
>>
>> Ugh. And since nobody sane has different values from the system ones, if
>> we miss some case we'll never notice on any sane platform ;(
> 
> As to your (3) and (4), I actually think that the best option would be to
> stop using '[lf]stat()' directly for "working tree stat", and instead just
> introduce a 'git_[lf]stat()' function that just always does the conversion
> (when necessary - the "conversion" can be a no-op on sane architectures)
> for us.
> 
> Right now, a _lot_ of the functions work either directly on 'st->st_mode'
> _or_ on random index entries, and that would be a major pain if they might
> ever be in "different number domains". So the easiest way to make sure
> that we _always_ use the GIT_IFxyz numbers would be to never ever have
> anything that uses the native ones even by mistake.
> 
> I've actually wanted to have a 'git_lstat()' wrapper for other reasons: it
> would have made it _so_ much easier to do breakpoints etc when doing the
> whole name lookup optimizations.
> 
> Note: there are various cases of '[lf]stat()' being used not for working
> tree entries, but for things like the pack files etc internal git files.
> Those should _not_ do the conversion - they should use the "native" stat()
> functions. It's only the working tree accesses we should need to do any
> conversion on, since those are the ones that are relevant for the index
> (and tree) comparisons.
> 

There are other benefits to the git_[fl]stat as well. Windows people would
probably be delighted if they were introduced. We have them in libgit2 for
that precise reason, since stat() sucks arse but some fileGetInfo() call is
at least reasonably fast on windows.

So why not make even pack file access work with the git macros? After all,
the conversion is a no-op on sane platforms, and it would probably be
easier to review patches if one doesn't have to remember that we have two
stat() implementations and which one to use where. Especially when we add
utility functions like read_file_chunk() (no, it doesn't exist) that could
operate on either internal files or work-tree files.

It would also make code-stealing to libgit2 a bit easier ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
