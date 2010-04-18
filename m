From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output (inc. current
 status)
Date: Sun, 18 Apr 2010 22:46:18 +0100
Message-ID: <203d6cefd3cd1020eb94fbd3d5e25eae@212.159.54.234>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <201004151107.33892.jnareb@gmail.com> <20100417095259.GA23110@coredump.intra.peff.net> <201004171502.42044.jnareb@gmail.com> <20100417140053.GA10997@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>,
	Eric Raymond <esr@thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 18 23:46:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3cK7-0000MO-UW
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 23:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab0DRVqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 17:46:22 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:47314 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753419Ab0DRVqV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Apr 2010 17:46:21 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 25CC6819C3A2;
	Sun, 18 Apr 2010 22:46:12 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 833043A78D;
	Sun, 18 Apr 2010 22:46:19 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IIvOpMPOoxMM; Sun, 18 Apr 2010 22:46:19 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B99C63A74D;
	Sun, 18 Apr 2010 22:46:18 +0100 (BST)
In-Reply-To: <20100417140053.GA10997@coredump.intra.peff.net>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145249>

On Sat, 17 Apr 2010 10:00:53 -0400, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 17, 2010 at 03:02:39PM +0200, Jakub Narebski wrote:
> 
>> Something like that (please remember that it is still in vague
beginnings
>> of an idea stage:
>> 
>>   OUT_OBJECT(
>>      OUT_FIELD("mode",   OUT_MODE, tree.mode), SP,
>>      OUT_FIELD("type",   "%s", tree.object.type), SP,
>>      OUT_FIELD("object", OUT_SHA1, tree.object.sha1), TAB,
>>      OUT_FIELD("file", OUT_FILE(sep), tree.filename), 
>>      sep
>>   );
> 
> Doing that would require variadic macros, which are a C99-ism. So you
> would have to do:
> 
>   OUT_OBJECT_START();
>     OUT_FIELD("mode", OUT_MODE, tree.mode); OUT_SP;
>     ...
>   OUT_OBJECT_END();

Also, backends such as JSON want to know which things are strings, and
which are numbers - as they print differently.  An XML backend may want to
distinguish even more (though I guess that depends on the design).

> which is not all that different from what Julian has now. I do think
> some type-specific conversions might be handy. They don't even need to
> be macros. E.g.,:
> 
>   void output_mode(struct output_context *oc, int mode)
>   {
>     output_strf(oc, "mode", "%06o", mode);
>   }
> 
> OTOH, looking over Julian's last patch series, there really aren't that
> many that would be generally applicable, and as you can see they only
> save a few characters, not even a line. A few bigger objects could be
> factored out, but he has already done that (e.g., see
> wt_porcelain_unmerged in his v2 3/4).

It might help standardise the output between commands if there were helper
functions for some of the larger structures - e.g. commits.  Though I don't
think that those functions would be able to do legacy output, due to the
current lack of cross-command output compatibility.  I'm starting to see
this with blame and diff-tree (and family), where they both want to output
information about commits.

I think that maybe I need to design and document the output structure for
common concepts - so that it would be possible to pass the output from any
command to a common parser, with matching utility functions in the code. 
Though, I'm not sure if there actually are any common concepts that need
outputting apart from commits.

Current Status
--------------

I had been planning to post an updated series this weekend, but I'm too
tired to attempt tidying things up for posting at the moment ... If you
want to see the current state then my current mess is available at
http://git.q42.co.uk/w/output.git.

A quick summary of main changes since v2:
  - backends are now in a subdirectory
  - blame, diff-tree, have --ouptut=... support for plumbing output
  - log has some support for --ouput=...
  - output library has extended API, including quoted strings and
is_structured_output function
  - backend API includes explicit functions for top-level items

-- 
Julian
