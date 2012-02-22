From: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
Subject: Re: git-svn show-externals and svn version
Date: Wed, 22 Feb 2012 16:27:23 +0100
Message-ID: <5B8386D7-3C01-4A58-A7AB-9AA43BB45572@nikolaus-demmel.de>
References: <E59CCE45-6F92-4748-9B6E-2A562647904B@nikolaus-demmel.de> <994D6101-DD43-4CD9-BB96-34807E3087C4@nikolaus-demmel.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 16:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0E6O-0000g5-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 16:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab2BVP11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 10:27:27 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:58101 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab2BVP10 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 10:27:26 -0500
Received: from dyna218-088.nada.kth.se (dyna218-088.nada.kth.se [130.237.218.88])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LyQ4I-1SUjso0ww2-015qIE; Wed, 22 Feb 2012 16:27:25 +0100
In-Reply-To: <994D6101-DD43-4CD9-BB96-34807E3087C4@nikolaus-demmel.de>
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:UUvyXlMSKWV3Eck5aa9qCNkgz/iMEGdwKQNjOMqrG26
 hcXlIyj9L9gVkLa049clCLQSHf9d1mNeIo1bv8zLLUXHpELFKU
 9LYOxFcwVTr1IEiqraQcc+8V6NwbW+Lq4y7Ml6gJTAh25OtiP9
 iUf7Yi1i5aViFP7jIo4pJjeEk3Ibs/zRxpHZPBp0yT0iiJt/mQ
 LkJQA8Mh/kThwpmhmLvaJm74kE92zMz7bDzyDXb28UZOCrRTvl
 LJbLKu1N7L6V3iFFIny3wLYEoxZCkr1rGz2GsWVv1CUGN6Olgp
 j67ujDS4N1DeISdSMwmbkLD0unVXDAk+ZGrI+IoCYzGPjmQiFi
 9TtxqZNa9eaEsrKSRNgBD0Sy/Y1miy5qlYVFRDszrtoBYtmNas
 o2kZ0grWvSXedfHHZX2jg5gc4jvNNrHhbl92PvU9k9HU5yZOKg
 Xi/9F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191261>

Hi,

I feel a bit like I am talking to myself, but I see from the high
traffic on this list that people are busy doing great things :-). I will
write anyway in case someone interested in git-svn listens.

Is there an appropriate place to file these kinds of feature/enhancement
requests?

So I've investigated the matter a bit further. Turns out in the
subversion SWIG language bindings there is an API function that parses
svn:externals definitions for you. See [1] for a recent (minimal) change
to make this function available in python. I guess supporting Perl
requires equally minimal changes. I haven't attempted it myself since I
know neither Perl nor SWIG.

How could this be used in git-svn show-externals? As layed out before, I
believe that the current output for the svn1.5 syntax is inherently
broken and we should not worry about backwards compatibility for
that. To maintain backwards compatibility with the output for the old
format and to give a canonical, easy to parse, output for any external
definition, I suggest sticking to the current format, just inserting the
parsed definition at the appropriate place with relative URLs completely
resolved to absolute ones.

The pre-svn1.5 syntax for external definitions was:

LOCAL-PATH [-r REVISION] ABSOLUTE-URL

The output for show-externals was thus (note that there is no parsing of
the external definition going on yet):

DIRECTORY-PREFIX/LOCAL-PATH [-rREVISION] ABSOLUTE-URL

The DIRECTORY-PREFIX was added because show-externals shows the external
definitions for all subdirectories recursively. With this prefix, every
line can be processed on its own. I suggest extending this output to:

DIRECTORY-PREFIX/LOCAL-PATH [-rREVISION] ABSOLUTE-URL[@PEG-REV]

Again, as mentioned above, show-externals should parse the definitions
and resolve relative URLs. Any lines that the svn API call cannot parse
should be completely ommited (e.g. commented lines and empty lines).

As I understand it show-externals is intended primarily for scripts for
further processing. With this extension existing scripts for the old
syntax should keep working also long as they don't feature
peg-revisions. With relative URLs resolved and a standard ordering old
and new syntax cannot be distinguished in terms of show-externals output
(except when there are peg-revsion are there).

Thoughts, comments, opinions?

Cheers,
Nikolaus

[1] http://thread.gmane.org/gmane.comp.version-control.subversion.user/109033/focus=109036

Am 21.02.2012 um 12:14 schrieb Nikolaus Demmel:

> Hi,
> 
> as a followup just another example of when the current show-externals gives a flaky output, namely when the line in the external definition is commented.
> 
> 
> $ git svn show-externals
> [...]
> # /src/
> /src/#https://codex.cs.bham.ac.uk/svn/nah/cogx/code/subarchitectures/vision.sa/tags/matlab-cosy-2008     matlab_cosy_2008
> /src/#https://codex.cs.bham.ac.uk/svn/nah/cogx/code/subarchitectures/vision.sa/tags/matlab-review-2009     matlab_review_2009
> 
> 
> Regards,
> Nikolaus
> 
> 
> Am 19.02.2012 um 19:53 schrieb Nikolaus Demmel:
> 
>> Hi,
>> 
>> I am currently investigating getting support for svn externals in git-svn (you might have noticed my other mails).
>> 
>> It turns out that there are quite a few scripts floating around that use the output of show-externals and then try to pull these externals with git-svn into independent repositories and add the folders as submodules to the root repository.
>> 
>> However, none of them work for me, and the primary reason AFAICT is that they were written for the pre svn1.5 format of svn:externals. From 1.5 svn supports a new format of svn:externals, which changes the order of revision, repository-url, and local folder, and also adds the posibility to add relative urls, peg-revisions, etc [1].
>> 
>> On top that it seems to me that the output of show-externals was purely designed for the old format. For example, if you compare the output of "git svn show-externals" with "git svn propget svn:externals" in an example repository using the new format [2], you find that the in the show-externals output the prepended "/" and "/instantiations/" at the beginning of each line does not make sense. If the target url (all relative with the ^ syntax in this case) and the sub-folder were swapped in order, as of pre 1.5 svn, it would make much more sense. Also apparently the code for show-externals was added in 2007 and not changed since, whereas svn 1.5 was released in 2008.
>> 
>> What I am not completely clear about is, whether svn 1.5 and later enforces the new syntax, or whether it just adds the new syntax and still has to support the old syntax (which could be distinguished, I guess, by checking of the last part on an entry is an absolute URL instead of a subfolder). Also, I'm not sure if the format depends on the version of the svn-server or the client. I would assume you can check out a repository hosted with svn 1.4 with a 1.5 client. Does the client process the svn:externals and present it in the new format, or is this the text string just taken from the server unaltered (I have not much knowledge of how svn actually works internally)?
>> 
>> Another question is whether the perl svn bindings present the svn:externals in some parsed, standard format, or do they just give you the raw text string?
>> 
>> In order to make show-externals more useful with the svn 1.5 and later syntax, one would maybe need to check the underlying svn version. I guess it is also quite important to retain backwards compatibility, such that users of externals with the old syntax would still get the same output as before.
>> 
>> I would suggest that the show-externals output should be as close as possible to the svn:externals syntax, possibly adapting the subfolder path for nested folders. However here the recursive display of externals for subfolders becomes a bit more tricky, since the URL can also be relative to the subfolder as of the new syntax. Maybe the easiest way to deal with the new syntax in show-externals would be to have each line like it is in the svn-properties, but add a space separated relative path to the corresponding subfolder at the beginning. A tool that uses this is then responsible for making sure the relative URLs are resolved correctly.
>> 
>> To sum up, given that all the questions I have are answered like I think is most likely, it would boil down to changing the output of show-externals for svn 1.5  and later just slightly, namely by inserting an additional space between the prepended subfolder and the actual svn:externals definition in each line.
>> 
>> Any thoughts and/or answers?
>> 
>> Cheers,
>> Nikolaus
>> 
>> 
>> [1] http://svnbook.red-bean.com/en/1.7/svn.advanced.externals.html
>> [2] http://paste.lisp.org/display/127858--
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
