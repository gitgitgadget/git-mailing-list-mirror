From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 18:56:34 +0530
Message-ID: <CALkWK0n+cWspBJtH7JFvsvoeHHuiWR0bGpYVU63e7O74XY=4sQ@mail.gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com> <1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 15:27:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTBLV-0003bo-OW
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 15:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332Ab3DSN1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 09:27:17 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:49137 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030254Ab3DSN1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 09:27:16 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so3401506iah.17
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zIwI7DJIFdn0Va7PSdePzN9arWP11OBTViy1EehV7Yg=;
        b=EcL25wCEq0Y83RVhVZa6fPnRcCqlS+e+adaYYnGInaX7Ij08iDYt8gTgkdRUn+PGS+
         E+j8tv4NkgtJsidwZQjV8k33gQJMCPyoEKJyIxkcum9uERh06MZgsVEpm8r3BmDc4eUL
         /M/LU1MrfT3fQAnPPzJ5CLvcVn6z8yWTgF/QtMPullHDqlXKoHpa04KtU16KM6H1XDYd
         otgC19nOsjGCcesqDeTqWgmv7AvqVubhKnxXRLKs35aZY9y5qA1VdFyJMQlLK3htljaW
         uC/ah8VqcUHLnAHW7jyxgmOUr9RsxIIQf51VNW6V74RX+elnxOecq+OqCyr6yiJbrAm5
         MrVQ==
X-Received: by 10.50.17.71 with SMTP id m7mr9317396igd.14.1366378035439; Fri,
 19 Apr 2013 06:27:15 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 19 Apr 2013 06:26:34 -0700 (PDT)
In-Reply-To: <1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221762>

Felipe Contreras wrote:
> The code finds the changes of a commit, runs 'git blame' for each chunk
> to see which other commits are relevant, and then reports the author and
> signers.
>
> Finally, it calculates what percentage of the total relevant commits
> each person was involved in, and show only the ones that pass the
> threshold.

Um, this didn't really explain it to me.  How about:

This command takes a patch prepared by 'git format-patch' as an
argument, and runs 'git blame' on every hunk of the diff to determine
the commits that added/removed those lines.  It then aggregates the
authors and signers of all the commits, and prints out these people in
descending order of the percentage of commits they were responsible
for.  It omits people are below a certain threshold.

>   % git cc-cmd 0001-remote-hg-trivial-cleanups.patch
>   Felipe Contreras <felipe.contreras@gmail.com> (author: 100%)
>   Jeff King <peff@peff.net> (signer: 83%)
>   Max Horn <max@quendi.de> (signer: 16%)
>   Junio C Hamano <gitster@pobox.com> (signer: 16%)

Won't my name appear as the first one on each of my patches?  Will I
be CC'ed on every patch that I send out?

>  contrib/cc-cmd/git-cc-cmd | 140 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100755 contrib/cc-cmd/git-cc-cmd

No README?

> diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
> new file mode 100755
> index 0000000..c7ecf79
> --- /dev/null
> +++ b/contrib/cc-cmd/git-cc-cmd
> @@ -0,0 +1,140 @@
> +#!/usr/bin/env ruby

What is the minimum required version of Ruby, by the way?  I see you
haven't used any fancy lazy enumerators or optional arguments
introduced in 2.0, so we should be okay practically speaking.

> +$since = '3-years-ago'
> +$min_percent = 5

Do I get to configure these two?  Also, the '$' prefix from your Perl
habit?  It's not idiomatic in Ruby afaik.

> +class Commit
> +
> +  attr_reader :id
> +  attr_accessor :roles
> +
> +  def initialize(id)
> +    @id = id
> +    @roles = []

What are id, roles exactly?  This isn't C where we have types, so
you're going to have to use some (rdoc-parseable) comments, if you
want me to be able to read the code without jumping around too much.

> +  end
> +
> +  def self.parse(data)
> +    id = author = msg = nil

This is not C.  You don't need to initialize stuff, unless you're
going to start accessing it using a .append() or similar.  In that
case, you need to initialize it as an empty list, so the compiler
knows what you're appending to.

> +    roles = {}

Shouldn't this be @roles?  Didn't you initialize it as an empty list
in initialize()?  Why did you suddenly change your mind and make it a
hashtable now?

> +    data.each_line do |line|
> +      if not msg
> +        case line
> +        when /^commit (.+)$/
> +          id = $1

Okay, I have no idea what you're parsing yet.  There's some commit
line, so I know this is not a raw commit object, as the name of the
class Commit would've indicated.

> +        when /^author ([^<>]+) <(\S+)>$/
> +          author = $1, $2
> +          roles[author] = 'author'

Huh?  the key is a two-item list, and the value is a hard-coded
'author' string?  If it's meant to be a sematic value, use a symbol.

Also, why don't you just collect the authors and signers in two
separate lists, instead of doing this and burdening yourself with
accumulation later?

> +        when /^$/
> +          msg = true

I can't see msg being used later in the function, so I don't know what
you're doing.

> +    roles = roles.map do |person, role|
> +      address = "%s <%s>" % person
> +      [person, role]

What?!  If you wanted address in the first place, why did you stuff a
two-member list into roles as the key?  Where is address being used?

> +  def import
> +    return if @items.empty?
> +    format = [ 'commit %H', 'author %an <%ae>', '', '%B' ].join('%n')
> +    File.popen(['git', 'show', '-z', '-s', '--format=format:' + format] + @items.keys) do |p|

Ah, you're using 'git show'.  I thought cat-file --batch was
especially well-suited for this task.  What do you need the
pretty-printing for?

> +      p.each("\0") do |data|
> +        next if data == "\0" # bug in git show?

What is the bug exactly?  It displays two consecutive \0 characters
sometimes, when given a bunch of items to display?

> +        id, roles = Commit.parse(data)
> +        commit = @items[id]
> +        commit.roles = roles

@items[id].roles = roles

> +  def each_person_role
> +    commit_roles = @items.values.map { |commit| commit.roles }.flatten(1)
> +    commit_roles.group_by { |person, role| person }.each do |person, commit_roles|
> +      commit_roles.group_by { |person, role| role }.each do |role, commit_roles|
> +        yield person, role, commit_roles.size

Unnecessary work if you'd chosen a better way to store the person =>
role mapping in the first place.

> +  def get_blame(source, start, offset, from)
> +    return unless source
> +    File.popen(['git', 'blame', '--incremental', '-C',
> +               '-L', '%u,+%u' % [start, offset],
> +               '--since', $since, from + '^',
> +               '--', source]) do |p|

While at it, why not blame -M -CCC?

> +  def from_patch(file)

You're not going to 'git mailsplit', like am does, first?

> +        when /^@@\s-(\d+),(\d+)/
> +          get_blame(source, $1, $2, from)

Okay, so this is where you get the arguments for the -L in blame.

> +exit 1 if ARGV.size != 1

No usage?

> +commits.each_person_role do |person, role, count|
> +  persons[person][role] = count

Oh dear.  Don't you think you're over-engineering here?  Just because
you can stuff anything into hashes/lists in Ruby, doesn't mean that
you should and kill efficiency.

> +persons.each do |person, roles|
> +  roles = roles.map do |role, count|
> +    percent = count.to_f * 100 / commits.size

Interesting.  You also take into account the size of the commits when
calculating the final score.

> +    next if percent < $min_percent
> +    "%s: %u%%" % [role, percent]
> +  end.compact

What are these nil elements you're filtering out with .compact?

Overall, it looks like the whole thing is one giant first draft
written in a big rush.  For a relatively simple task, you've used a
lot of complex data structures and complicated things beyond belief.
I'm sorry, but this giant mess wasn't at all a pleasure to read.  No
doubt that the idea is good though.  I'm stopping here.
