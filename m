From: tanay abhra <tanayabh@gmail.com>
Subject: [RFC][GSoC] Calling for comments regarding rough draft of proposal
Date: Thu, 20 Mar 2014 01:22:28 +0530
Message-ID: <CAEc54XAvdOFQLFE_odEKDGjrqNo+vtYfHafUvKS0OazUQ1r-Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:52:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQMXT-0001jW-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbaCSTwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:52:30 -0400
Received: from mail-vc0-f196.google.com ([209.85.220.196]:52115 "EHLO
	mail-vc0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbaCSTw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:52:28 -0400
Received: by mail-vc0-f196.google.com with SMTP id il7so2281975vcb.11
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Qeom3czEF4r8aZqpQZLUZ6+4ukcPXQ58BTbVGNOUYmc=;
        b=O8sMQfcqQUpa4A9DCSBuunn3/rerfTGMKDJ9i60M/2yE3jHXa+N7k/RWNJMCj9QKdu
         NBUYFzkNTz7PgOSVN/8MhHf4dcJoeMSRmcnLj0KhRI/RVnnPCjXvf7LncJSt32cNsVmS
         dZnv4pbw7oITiyFWiNKPI3voNZQjvq73tonnTaQ+l5MXDQOhAZbE0VDNTCFdoGyy1zyC
         mLDS/sUdm95SKWtYl5iBL/BPFZOvcq/lx0zAQfnrh8mfKktGdPsQq8UfK3S7D7guh7zb
         7cAYlNJb1zgR4+V3PZOHzBUqO1Qvc4l0q/3EtQlLU9z+YAVkPzMT8SQl46URubxhi6AC
         BusA==
X-Received: by 10.58.161.101 with SMTP id xr5mr1464535veb.36.1395258748289;
 Wed, 19 Mar 2014 12:52:28 -0700 (PDT)
Received: by 10.58.111.202 with HTTP; Wed, 19 Mar 2014 12:52:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244485>

Hi,
      I have already done the microproject, which has been merged into
main last week. I have prepared a rough draft of my proposal for
review, read all the previous mailing list threads about it.I am
reading the codebase little by little.

Please suggest improvements on the following topics,

1.I have read one-third of config.c and will complete reading it by
tomorrow.Is there any other  piece of code relevant to this proposal?

2.Other things I should add to the proposal that I have left off?I am
getting confused what extra details I should add to the proposal. I
will add
the informal parts(my background, schedule for summer etc) of the
proposal later.

3.Did I understand anything wrong or if my approach to solving
problems is incorrect,if yes, I will redraft my proposal according to
your suggestions.

------------------------------------------------------------------------------
#GSoC Proposal : Git configuration API improvements
-------------------------------------------------------------------------------

#Proposed Improvements

* Fix "git config --unset" to clean up detritus from sections that are
left empty.

* Read the configuration from files once and cache the results in an
appropriate data structure in memory.

* Change `git_config()` to iterate through the pre-read values in
memory rather than re-reading the configuration
  files.

* Add new API calls that allow the cache to be inquired easily and
efficiently.  Rewrite other functions like
 `git_config_int()` to be cache-aware.

* Rewrite callers to use the new API wherever possible.

* How to invalidate the cache correctly in the case that the
configuration is changed while `git` is executing.

#Future Improvements

*Allow configuration values to be unset via a config file

--------------------------------------------------------------------------
##Changing the git_config api to retrieve values from memory

Approach:-

We parse the config file once, storing the raw values to records in
memory. After the whole config has been read, iterate through the records,
feeding the surviving values into the callback in the order they were
originally read
(minus deletions).

Path to follow for the api conversion,

1. Convert the parser to read into an in-memory representation, but
   leave git_config() as a wrapper which iterates over it.

2. Add query functions like config_string_get() which will inquire
cache for values efficiently.

3. Convert callbacks to query functions one by one.

I propose two approaches for the format of the internal cache,

1.Using a hashmap to map keys to their values.This would bring as an
 advantage, constant time lookups for the values.The implementation
 will be similar to "dict" data structure in python,

 for example, section.subsection --mapped-to--> multi_value_string

 This approach loses the relative order of different config keys.

2.Another approach would be to actually represent the syntax tree of the
  config file in memory. That would make lookups of individual keys more
  expensive, but would enable other manipulation. E.g., if the syntax
  tree included nodes for comments and other non-semantic constructs, then
  we can use it for a complete rewrite.

 And "git config" becomes:

  1. Read the tree.

  2. Perform operations on the tree (add nodes, delete nodes, etc).

  3. Write out the tree.

and things like "remove the section header when the last item in the
section is removed" become trivial during step 2.


I still prefer the hashmap way of implementing the cache,as empty
section headers  are not so problematic(no processing pitfalls) and
are sometimes annotated with comments  which become redundant and
confusing if the section header is removed.As for the aesthetic
problem
I propose a different solution for it below.

----------------------------------------------------------------------
##Tidy configuration files

When a configuration file is repeatedly modified, often garbage is
left behind.  For example, after

    git config pull.rebase true
    git config --unset pull.rebase
    git config pull.rebase true
    git config --unset pull.rebase

the bottom of the configuration file is left with the useless lines

    [pull]
    [pull]

Also,setting a config value, appends the key-value pair at the end of
file without checking for empty main keys
even if the main key(like [my]) is already present and empty.It works
fine if the main key with an already present
sub-key.

for example:-
    git config pull.rebase true
    git config --unset pull.rebase
    git config pull.rebase true
    git config pull.option true
gives
    [pull]
    [pull]
        rebase = true
        option = true

Also, a possible detriment is presence of comments,
For Example:-
    [my]
            # This section is for my own private settings

Expected output:

  1. When we delete the last key in a section, we should be
     able to delete the section header.

  2. When we add a key into a section, we should be able to
     reuse the same section header, even if that section did
     not have any keys in it already.

Possible approaches:-

1.Leave the empty section header as it was and when a new value is set,
  reuse the header instead of appending at the end of the config file.
  I am going through the code to find find other solution for this problem.

links:-
[1]http://thread.gmane.org/gmane.comp.version-control.git/219505
[2]http://thread.gmane.org/gmane.comp.version-control.git/208113

-----------------------------------------------------------------------

Thanks,
Tanay Abhra.
