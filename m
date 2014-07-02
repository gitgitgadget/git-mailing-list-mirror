From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Wed, 02 Jul 2014 16:32:23 +0200
Message-ID: <vpqbnt7bzm0.fsf@anie.imag.fr>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
	<vpqoax8m8bh.fsf@anie.imag.fr> <53B3F403.6030501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:32:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2LaR-0001ul-BU
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 16:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbaGBOcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 10:32:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52949 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575AbaGBOcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 10:32:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s62EWL1f026007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jul 2014 16:32:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s62EWNDf002027;
	Wed, 2 Jul 2014 16:32:23 +0200
In-Reply-To: <53B3F403.6030501@gmail.com> (Tanay Abhra's message of "Wed, 02
	Jul 2014 17:28:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Jul 2014 16:32:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s62EWL1f026007
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404916342.60608@wlhpHrxTrOW4eDFiT66oEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252782>

Tanay Abhra <tanayabh@gmail.com> writes:
> On 7/2/2014 2:44 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:

> Maybe a reworded sentence may work,
> `git_configset_get_value_multi` returns a list of values sorted in order of
> increasing priority (i.e. last match will be at the end of the list.)

OK.

>>> read from usual config files(repo specific .git/config, user wide
>>> ~/.gitconfig and the global /etc/gitconfig). `the_config_set` uses a
>>> single hashmap populated using git_config(). The reason for doing so is
>>> twofold, one is to honour include directives, another is to guarantee O(1)
>>> lookups for usual config values, as values are queried for hundred of
>>> times during a run of a git program.
>> 
>> What is the reason to deal with `the_config_set` and other config sets
>> differently? You're giving arguments to store `the_config_set` as a
>> single hashmap, but what is the reason to store others as multiple
>> hashmaps?
>> 
>> And actually, I don't completely buy your arguments: having 3 or 4
>> hashmaps (.git/config, ~/.gitconfig, ~/.config/git/config and
>> /etc/gitconfig) would be a O(4) lookup, which is still O(1), and you
>> could deal with include directives by having ".git/config and included
>> files" in a hashmap, "~/.gitconfig and included files" in a second
>> hashmap, ...
>> 
>> My guess is that the real argument is "git_config already does what I
>> want and I'm too lazy to change it". And I do consider lazyness as a
>> quality for a computer-scientist ;-).
>> 
>> I would personally find it much simpler to have a single hashmap. We'd
>> lose the ability to invalidate the cache for only a single file, but I'm
>> not sure it's worth the code complexity.
>> 
>
> Point noted. I can take the multiple hashmap route for `the_config_set`.
> Still, since it will be the most used config set in the code and for each
> query it would have to look through n hashmaps hampering performance. I
> can change it if you want but like you, I don't think it is worth the code
> complexity.

That's why my suggestion is to use a single hashmap everywhere.

I don't have strong opinion either way, but whichever way you go, you
should justify the choice better in the commit message.

>>> +The config API also provides type specific API functions which do conversion
>>> +as well as retrieval for the queried variable, including:
>>> +
>>> +`git_config_get_int`::
>>> +Parse the retrieved value to an integer, including unit factors. Dies on
>>> +error; otherwise, allocates and copies the integer into the dest parameter.
>>> +Returns 0 on success, or 1 if no value was found.
>> 
>> It seems strange to me to return 1 here, and -1 in git_config_get_value
>> to mean the same thing.
>> 
>
> Noted. Some of the type specific function return -1 on wrong parsing, I will
> put return value 1 for no value found in all of the cases.

I'm not sure I fully get the existing convention. My understanding is
that when the extracted value is returned, -1 is used as a special value
to mean "no value" (e.g. git_config_maybe_bool can return 1, 0 or -1),
but when the extracted value is written to a by-address parameter, then
the return value is 1 or 0.

>>> +static struct hashmap *get_config_hash(const char *filename, struct config_set *cs)
>>> +{
>>> +	int i;
>>> +	for(i = 0; i < cs->nr; i++) {
>>> +		if (!strcmp(cs->item[i].filename, filename))
>>> +			return &cs->item[i].config_hash;
>>> +	}
>>> +	return add_config_hash(filename, cs);
>>> +}
>>> +
>>> +static struct config_hash_entry *config_hash_find_entry(const char *key, const char* filename,
>>> +							struct config_set *cs)
>> 
>> I don't get the logic here.
>> 
>> Either the caller explicitly manages a config_set variable like
>> 
>>   config_set my_set = git_configset_init();
>>   git_configset_add_file(my_set, "my-file");
>>   git_configset_get_value(my_set, "some.variable.name");
>> 
>> Or there's an implicit singleton mapping files to hashmaps to allow the
>> user to say
>> 
>>   git_configset_get_value("my-file", "some.variable.name");
>> 
>> without asking the user to explicitly manipulate config_set variables.
>> 
>> It seems to me that your solution is a bad compromise between both
>> solutions: you do require the user to manipulate config_set variables,
>> but you also require a filename to look for the right entry in the list.
>> 
>> Did you miss the end of Junio's message:
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/252567
>> 
>> ?
>>
>
> This is an internal function which is used to iterate over every `config_set`
> item which contains a hashmap and filename as an identifier.
> The exposed API which I documented above doesn't require the user to pass the
> filename when querying for a value.
>
> The API works like this, suppose there are two files,
> A.config	B.config
> [foo]		[foo]
> a = b		a = d
> a = c		a = e
>
> config_set *my_set = git_configset_init();
> git_configset_add_file(my_set, "A.config");
> git_configset_add_file(my_set, "B.config");
> git_configset_get_value(my_set, "foo.a");
>
> Here get_value calls config_hash_find_entry once for each configset_item
> "A.config" and "B.config" with key as "foo.a". which in turn returns
> config_hash_item which contains the key and the value list.

OK, I understand what you did. But it still seem wrong to me. If you
inline functions, you are doing something like

for (f in files) { // in git_configset_get_value
   for (g in files) { // in get_config_hash
      if (f == g) {
         take the hashmap for g.
      }
   }
}

This is O(n^2) to iterate over an ordered list. OK, the list is small,
but still, why not iterate normally over the array?

Algorithmically speaking, you do not need the file names here, just
iterate over an array of hashmaps. Filenames do not harm in struct
config_set, but they are just metadata, not usefull to do the search.

> We get two string_lists containing values for the key foo.a,
> {b,c} and {d,e} corresponding to A.config & B.config  respectively.
>
> get_value then returns the value with the highest priority which is 'e'
> after going through both of the lists and picking the last one.
> These steps are done by internal functions not by the user facing
> API ones.

But then, I have to wonder again what is the benefit of having multiple
hashmaps in the config_set, since it has no user-visible benefit.

>> If the user explicitly asks for a single entry in the list, then why
>> group them in a list? I guess the question is the same as above, and the
>> more I read the patch, the more I think a config_set should contain a
>> single hashmap.
>>
>
> Do you think so after reading the whole patch? It would be much easier
> to implement config_set using a single hashmap . But Junio had suggested
> that it would be much better for config_set to be a collection of hashmaps
> and `the_config_set` to contain a single hashmap[1].
>
> [1]http://thread.gmane.org/gmane.comp.version-control.git/252329/focus=252460

I do not read the message like you. Junio gives pros&cons of "everything
in a single hashmap" Vs "one hashmap per file", and explicitely
concludes with

| I don't know at this point, and thinking these things through
| to arrive at a good design is part of the GSoC project after all, so
| I'd rather not to think it through to the end myself ;-).

I do not read "there should be multiple hashmaps, except in the case of
the_configset which should be handled differently".

To summarize:

Advantages of using a single hashmap per configset:

1) Code is simpler

2) Lookup is slightly more efficient

Advantages of using one hashmap per configset:

A) Allows sharing hashmaps between configsets

B) Allows selectively refreshing the config for a single file without
   touching the other files' hashmaps.

C) Would allow more operations like "tell me which file contains the
   config key foo.bar", that could be useful in some situation.

Right now, I do not think that your implementation uses any of A), B) or
C), so you're doing something uselessly complex.

In the future, my feeling is that A) is essentially irrelevant (we're
talking about a few hundreds of entry for large config files, not
something we want to fine-tune in memory), B) would raise tons of
corner-cases and would be hard to get right compared to the benefit. C)
could be interesting, but the most common case would be to use
the_configset, in which there's only one hashmap so it's not applicable
without a big code change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
