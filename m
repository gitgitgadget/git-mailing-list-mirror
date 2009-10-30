From: Ian Clatworthy <ian.clatworthy@canonical.com>
Subject: Re: [Vcs-fast-import-devs] What's cooking in git.git (Oct 2009, #01;
 Wed, 07)
Date: Fri, 30 Oct 2009 13:50:05 +1000
Message-ID: <4AEA626D.8060804@canonical.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>	<alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de> 	<fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com> 	<20091008173900.GI9261@spearce.org> <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	vcs-fast-import-devs@lists.launchpad.net, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 04:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3iVJ-0007Ac-4Q
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 04:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbZJ3DuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 23:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbZJ3DuA
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 23:50:00 -0400
Received: from bld-mail19.adl2.internode.on.net ([150.101.137.104]:38252 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754652AbZJ3DuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 23:50:00 -0400
Received: from [192.168.1.107] (unverified [118.208.166.168]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 7480747-1927428 
	for multiple; Fri, 30 Oct 2009 14:19:58 +1030 (CDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131672>

Sverre Rabbelier wrote:
> Heya,
> 
> [edited Shawn's message somewhat to be more relevant to vcs-fast-import-dev]

Thanks Sverre. Before I start, sorry for taking so long to reply to this.

> On Thu, Oct 8, 2009 at 19:39, Shawn O. Pearce <spearce@spearce.org> wrote:
>> IIRC my problem with options was we weren't enforcing them, and yet
>> they were necessary for a successful import, e.g. import-marks or
>> export-marks.  A minor error could cause a successful looking import
>> that is wrong due to the marks being messed up, or not saved out.
>>
>> So I was leaning towards making these features, but then they
>> aren't necessarily compatible with the other fast-import tools.

My strong preference is for:

* feature = anything impacting semantics
* option = tool-specific with no impact on semantics permitted.

Both features and options ought to OS independent (where possible).

>> I think we want to declare features for import-marks and export-marks:
>>
>>  feature import-marks=in.marks
>>  feature export-marks=out.marks
>>
>> and define these as paths to local files which store a VCS specific
>> formatted mapping of fast-import mark numbers to VCS labels.

+1 to making these features and to tightening up the semantics so we can
reliably use them across tools. Explicitly specifying the local path
names worries me though. Consider someone using fastimport tools to
maintain multiple mirrors in different tools:

1. Step 1 is fast-export from tool A
2. Step 2 is fast-import into tool B
3. Step 3 is fast-import into tool C

What should the stream look like then? Does it need to change if we want
an additional mirror in tool D? (Note that the mark files will need to
be reused to transfer changes back to the master.)

>> Other options that are clearly git should be declared as:
>>
>>  option git max-pack-size=2048
>>
>> with the meaning of option being declared something like:
>>
>>  If the parsing VCS name appears as the first argument, the parsing
>>  VCS must recognize and support the supplied option, and if not
>>  recognized or not supported must abort parsing altogether.
>>
>>  If the parsing VCS name is not the first argument, it must entirely
>>  ignore the option command and not try to process its contents.

+1. By forcing tools to know about options specific to them, we avoid a
range of bugs processing newer streams with older tools.

> I think it makes to ignore options that are not for our vcs, as long
> as options that change import behavior (such as marks, date-format)
> are combined with, say, 'feature tool=git'. This way we can be sure
> that when outputting out a vcs specific stream, it is only parsed by
> that vcs.

I don't think options should be permitted to change import behavior. In
other words, we should actively discourage vcs-specific streams. Any VCS
using features has a (moral) responsibility IMO to at least define those
publicly. Here's a poor start (EBNF syntax would be far better than just
text) on the Bazaar side:
http://doc.bazaar-vcs.org/migration/en/data-migration/fast-export.html#interoperability.

Maybe we need a central wiki page (say) where these can be registered?
I'd offer to setup a "fastimport" web site in a Bazaar branch and track
feature specification bugs in Launchpad but maybe a wiki page would be a
little more neutral ground. :-) :-)

Ian C.
