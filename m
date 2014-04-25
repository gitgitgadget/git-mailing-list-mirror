From: tanay abhra <tanayabh@gmail.com>
Subject: [GSoC 2014] Accepted GSoC student introduction
Date: Sat, 26 Apr 2014 00:06:54 +0530
Message-ID: <CAEc54XDU2OtSfnz1VsN1R+a4D0yAFm2EnDJUW1Wk8myT12jd5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:37:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdkzh-00034H-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbaDYSg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:36:58 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:65238 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaDYSgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:36:55 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so5254697veb.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=q2sX/SfCcMF4Jijb4u7Zi+Xge35v0s18jRUVJeIA47Y=;
        b=SNNFHBEzdgcr0/0PBv2My9UASe+0289MpEnLuuoxdmIrpf51pnKmFcZlrivcYRzpiF
         P9UG/0XVhhEW2Ur6ag0m5eykxwSffMZXxnyMLvzR+FLYUfKoKQizPuDHx1XOpCAu3d9Z
         ATIDfpK30ami2O8LBoUwch+ZvDbAqkmgLSMU0ueyxmfBZiitQMJlRrCXf2YmuoIdOy1w
         M2ywdZl+0805gRgw8YB3kwXFToFm9dyj3Fqd5kYcCIL8HKV2oJg0UgFI4XhxYB7aLLuP
         cTYv3eyybeOJYVLGbtAmyjol5LEA7BYzV4uLG6dA34zEgt4WiHaP+zobx//S8Kpogvgt
         D8Ww==
X-Received: by 10.220.163.3 with SMTP id y3mr7911256vcx.7.1398451014826; Fri,
 25 Apr 2014 11:36:54 -0700 (PDT)
Received: by 10.58.111.202 with HTTP; Fri, 25 Apr 2014 11:36:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247091>

Hi,

I am one of the three selected GSoC(Google summer of Code) students by
Git this year.
I am a third year computer science student from India. First, I want to thank
you all for guiding me through the patch review process and being
patient with me. I learned a lot from you all
and this helped me polishing my proposal, so I want to thank you all
for giving me this opportunity.

My mentors for the project are Matthieu Moy and Ramkumar Ramachandra. My
proposal topic is "Git configuration API improvements" and I am
appending the whole proposal below
ad verbatim for you all to review. I had posted it earlier but it may
have gotten lost in the noise.
I am looking forward to having a great summer working on git.


##GSoC Proposal : Git configuration API improvements


Abstract:
-----------

The current method for reading values from the config file (summarized
from reading config.c, bulitin/config.c and
api-config.txt)in the disk is parsing and reading the file each time a
function calls for a config value.
git_config() feeds every variable and value to the callback function
which decides what to do with them. Due to
this approach, it is not uncommon for the configuration to be parsed
several times during the run of a Git
program, with different callbacks picking out different variables
useful to themselves. I propose that instead of
reading and parsing the config file multiple times from the disk
during a process run, we will construct a
in-memory representation of the config file the first time a config
value is queried for. Also, the callbacks will
be rewired to use the new API functions provided for efficient lookups
from the internal cache. After this
implementation is validated, new features can be added such as
unsetting values from config file.



#Proposed Improvements

* Fix "git config --unset" to clean up detritus from sections that are
left empty and some more aesthetic
concerns illustrated below .

* Read the configuration from files once and cache the results in an
appropriate data structure in memory.

* Change git_config() to iterate through the pre-read values in memory
rather than re-reading the configuration
  files.

* Add new API calls that allow the cache to be inquired easily and efficiently.

* Rewrite callers to use the new API wherever possible.

#Possible Problems with this approach,

* How to invalidate the cache correctly in the case that the
configuration is changed while `git` is executing.

* What to do with the comments, which are generally found in config
files, and can be places anywhere(above a
  section header , below a section header etc.)?

#Future Improvements

* Allow configuration values to be unset via a config file

--------------------------------------------------------------------------
##Changing the git_config api to retrieve values from memory
--------------------------------------------------------------------------

#Current Implementation of the git-config subsystem:
----------------------------------------------------

Config files are parsed linearly, and each variable found is passed to
a caller-provided callback function. The
callback function is responsible for any actions to be taken on the
config option, and is free to ignore
some options. It is not uncommon for the configuration to be parsed
several times during the run of a Git program,
with different callbacks picking out different variables useful to themselves.

A config callback function takes three parameters:

- the name of the parsed variable. This is in canonical "flat" form: the
  section, subsection, and variable segments will be separated by dots,
  and the section and variable segments will be all lowercase. E.g.,
  `core.ignorecase`, `diff.SomeType.textconv`.

- the value of the found variable, as a string. If the variable had no
  value specified, the value will be NULL (typically this means it
  should be interpreted as boolean true).

- a void pointer passed in by the caller of the config API; this can
  contain callback-specific data

A config callback should return 0 for success, or -1 if the variable
could not be parsed properly.

#Current Config Querying:
-----------------------

Most code in git,calls `git_config` to look up variables in all config
files that Git knows about, using the normal precedence rules.
To do this, it calls with a callback function and void data pointer.

`git_config` will read all config sources in order of increasing
priority. The logic flow is attached as a image[1]
. Thus a callback should typically overwrite previously-seenentries
with new ones (e.g., if both the user-wide
`~/.gitconfig` and repo-specific `.git/config` contains `color.ui`,
the config machinery will first feed the
user-wide one to the callback, and then the repo-specific one; by
overwriting, the higher-priority repo-specific
value is left at the end).

The current precedence order rates the repo-config file the highest.

The `git_config_with_options` function lets the caller examine config
while adjusting some of the default behavior
of `git_config`. It takes two extra parameters:

`filename`::
If this parameter is non-NULL, it specifies the name of a file to
parse for configuration, rather than looking in the usual files. Regular
`git_config` defaults to `NULL`.

`respect_includes`::
Specify whether include directives should be followed in parsed files.
Regular `git_config` defaults to `1`.

There is a special version of `git_config` called `git_config_early`.
This version takes an additional parameter to specify the repository
config, instead of having it looked up via `git_path`. This is useful
early in a Git program before the repository has been found.

I have made a logic diagram for better understanding the query config subsystem,
[1]http://imgur.com/CToJXTr

#Writing config files to disk:
------------------------------

Git provides two internal functions for setting and unsetting
variables in config files,

*git_config_set(const char *key, const char *value)
*git_config_set_in_file(const char *config_filename,const char *key,
const char *value)

who call git_config_set_multivar and git_config_set_multivar_in_file
respectively.

In the end git_config_set_multivar_in_file does all the work.
For setting and unsetting values it checks the argument value.

If value==NULL, unset in (remove from) config,
if value_regex!=NULL, disregard key/value pairs where value does not match.
if multi_replace==0, nothing, or only one matching key/value is replaced,
else all matching key/values (regardless how many) are removed,
before the new pair is written.

This function does this:

    - it locks the config file by creating ".git/config.lock"

    - it then parses the config using store_aux() as validator to find
      the position on the key/value pair to replace. If it is to be unset,
      it must be found exactly once.

    - the config file is mmap()ed and the part before the match (if any) is
     written to the lock file, then the changed part and the rest.

   - the config file is removed and the lock file renamed to it.


#New Approach and implementation details:
----------------------------------------

We parse the config file once, storing the raw values to records in
memory. After the whole config has been read,
iterate through the records, feeding the surviving values into the
callback in the order they were originally read
(minus deletions).

Path to follow for the api conversion,

1. Convert the parser to read into an in-memory representation, but
   leave git_config() as a wrapper which iterates over it.

2. Add query functions like config_string_get() which will inquire
cache for values efficiently.

3. Convert callbacks to query functions one by one.

#Choosing a data structure for internal cache:
----------------------------------------------

Currently, the callbacks receives key,value pairs after parsing in a
flat form like,"diff.sometype.textconv" and
value "true" .These key-value pairs easily translate to a hashmap or a
dictionary structure.
This data-structure  reflects the configuration variables themselves,
not the way they appear in the config
file. A map (hashtable) associating to each config variable the
corresponding value (which maybe a scalar
value,boolean or a list, depending on the variable) would be most
appropriate in my opinion.They will be saved as
"string":"string list" pairs as there are already many helper
functions to help converting the string values into
their appropriate data type.

Advantages of using a Hashmap:-
------------------------------

>>Constant time lookups(O(1)) and deletions.After the initial parsing ,the system would use the hashmaps for
  lookups.
>>Read-only accesses happen far more often than updates, so the data structure is optimised for lookups.
>>Since the key,value pairs are string like for example, section.subsection.variable = value ,they are easily
  hashable and are appropriate for this type of data structure.
>>As for the implementation details, there is already a generic hashmap implementation built-in .(described in
  api-hashmap.txt).I could roll out a new one if you want.
>>Unsetting previously set value would become as easy as deleting the key-value pair ,or setting a invalid flag
  for that pair during file parsing stage.

#Complications in using a hashmap:-
-----------------------------------

>>To report errors in the config files, a node remembering where the key-value pair came from and from which file,
  will have to be maintained. It would also be useful in writing
key-value pairs back to the file in order of
  reading.
>>In the current code, when somebody does git_config_set() and then later uses git_config() to grab the value of
  the variable set with the first call, we will read the value written
to the file with the first call. With the
  proposed change, if we parse from the file upfront, callers to
git_config_set() will need to somehow invalidate
  that stale copy in memory.

  We could do two things about it,
  1>Easy approach- Discard and rebuilt the cache every time git_config
queries for a value. This is currently, what
  we are doing, reading and parsing the file every time, a value is
called for using git_config.
  2>Harder approach- Update the changed part. This seems doable, but I
will have to experiment with it to see if
  it works or not as I am not too much familiar with the code base.
But take this  initial proposal, git_config_set
  creates a lock file , updates it, deletes the original config file
and renames the lockfile to a new config file.
  We could take this approach and apply it to the in memory-cache and
lock it until git_config_set works on it.

 >>Precedence order of variables read from different sources.

  Currently the config is read from multiple sources (repo config file
`.git/config`,user config file
  `$HOME/.gitconfig` and system wide config file `/etc/gitconfig`)
with the repo config file having the highest
  preceding order. It is read last in the current parsing order. In my
implementation the value of variables will
  be implemented as list of strings. So it will be a case of "last one
wins", where the value with the highest
  precedence would be inserted last in the list. So a caller asking
for a value would just read the last value in
  the list without worrying about no allocation or  ownership complexity.

#Changing the parsing code
--------------------------

Currently git_parse_source parses the file and feeds each value to the
callback function. git_config uses it. To be
backward compatible, I would change the git_parse_source to have a
switch for the default parsing behaviour and
updated parsing parsing behaviour.

In the updated one, the file will be read only once to construct the
hash map and after that it would iterate over
the values querying the cache each time. The callback would be fed
these read values only.

#Add new API Calls
------------------

A new set of helpers for retrieving values in a non-callback way will be added.
Possible implementation of the API,

>>extern int get_config_string_multi(const char * variable, int * num_values, const char **values)

Argument list: key: used for retrieving the value list for the respective key
               num_values: returns no of values in the list
               vales: list containing the values as string

>> A singleton wrapper would look like char *git_get_config_string(const char *name)
   return the last value for the key "name"(thus implementing the last
one wins semantic)
   Possible implementation (copied directly from the mailing list discussion )

   const char *git_get_config_string(const char *name)
        {
        const char **values, *result;
                int num_values;

            if (git_get_config_string_multi("sample.str", &num_values, &values))
                return NULL;
                result = num_values ? values[num_values - 1] : NULL;
                free(values);
        return result;
    }
As there is already a set of helpers for validating the values and
converting them to appropriate data types
in config.c there won't be any need for specialized functions for each
data type.

#Rewrite callers:
----------------

After implementing the above ,this would be just busywork and pretty
much doable.The callbacks would have to be
reworked to use the new api functions.

----------------------------------------------------------------------
##Tidy configuration files
----------------------------------------------------------------------

#First case:

When a configuration file is repeatedly modified, often garbage is
left behind.  For example, after

    git config pull.rebase true
    git config --unset pull.rebase
    git config pull.rebase true
    git config --unset pull.rebase

the bottom of the configuration file is left with the useless lines

    [pull]
    [pull]

#Case 2

Also,setting a config value, appends the key-value pair at the end of
file without checking for matching empty main
section headers. It works fine if the main section header has an
already present sub-key.

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
#Case 3

Also, a possible detriment is presence of comments,
For Example:-
    [my]
            # This section is for my own private settings
Another example you need to consider is

    # Comment regarding the entire [my] section
        [my]
            # Comment on the item foo
                foo = true
        # Comment on the item bar
                bar = false

What should "git config --unset my.foo && git config -unset my.bar" do?
What if these are done in a different order?


#Expected output:

  1. When we delete the last key in a section, it automatically delete
the section header.(This is debatable)

  2. When we add a key into a section, we should be able to
     reuse the same section header, even if that section did
     not have any keys in it already(empty section header).

#Suggested Approaches :-
--------------------------------------

Case first
  Leave the empty section header as it was and when a new value is set,
  reuse the header instead of appending at the end of the config file.
  This can be implemented by changing git_config_set a little, even
without using the internal cache.
  If we use the internal cache,to rewrite the file after setting or
unsetting the value, this problem will vanish
  automatically.

Case second
  This is also a git_config_set problem and can be solved by either
using the cache to rewrite the file every time
  setting or unsetting the value, or reuse the empty section header
when adding a new value pair into it.

Case three
  Its a controversial issue , in which the comments added by the user
might signify anything(commenting on section
  header or a particular variable or the above header).I think the
comments should be left as it is , as some users
  leave empty section headers and comments for future use. So removing
them may prove detrimental.But , other
  suggestions are welcome for this problem .The mailing list itself
was conflicted about this option.

links:-
[1]http://thread.gmane.org/gmane.comp.version-control.git/219505
[2]http://thread.gmane.org/gmane.comp.version-control.git/208113

------------------------------------------------------------------------------------------------------------------

Cheers,
Tanay Abhra.
