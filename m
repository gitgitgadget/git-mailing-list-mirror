From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 20:10:08 +0530
Message-ID: <CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com> <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 16:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue4n8-0004Qe-Au
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 16:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab3ESOku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 10:40:50 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:49541 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab3ESOkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 10:40:49 -0400
Received: by mail-ia0-f182.google.com with SMTP id z3so6748686iad.27
        for <git@vger.kernel.org>; Sun, 19 May 2013 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HYs2rzsb1Q+U/uFKcgNirroRAUdUnTQyOkleGcjlwZQ=;
        b=aZOQhBu/3thLHgMPZhhGqR+K3lN+DZrGt/UmGlb9LpUEcm0tE8e+Nv832dLjChyGfT
         MWeWnX1pCtDR5G53FhVtIi3rzzRfc6J8RdrLACiUiPRT8w3Hf6NpKPXR+cI7BKNPejtR
         3VP84Z4lAA+iWUhpriu3BasARy/Pdax2BovJzBk940YV9xckpNyte2g7LrEhjAozd3d9
         gWArxwDcJ3X0ynW/py/Ys9VYC4OAWgtc8pHJlB0z6AFxArv9Ss+3uL7r+neFX/teCGu/
         +muKRxYdKdJishTKMB72W2EstmSFV2YWMyKSh0YGpOdi5tcNKd9QvAV/463eqZ8RJXv9
         tiUg==
X-Received: by 10.50.120.68 with SMTP id la4mr2816836igb.49.1368974448957;
 Sun, 19 May 2013 07:40:48 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 07:40:08 -0700 (PDT)
In-Reply-To: <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224888>

Okay, let's look at this part.

Felipe Contreras wrote:
> diff --git a/contrib/related/git-related b/contrib/related/git-related
> new file mode 100755
> index 0000000..4f31482
> --- /dev/null
> +++ b/contrib/related/git-related
> @@ -0,0 +1,124 @@
> +#!/usr/bin/env ruby
> +
> +# This script finds people that might be interested in a patch
> +# usage: git related <file>
> +
> +$since = '5-years-ago'
> +$min_percent = 10
> +
> +def fmt_person(name, email)
> +  name ? '%s <%s>' % [name, email] : email
> +end
> +
> +class Commit
> +
> +  attr_reader :persons
> +
> +  def initialize(id)
> +    @id = id
> +    @persons = []
> +  end

Okay, although I'm wondering what id is.

> +  def parse(data)
> +    msg = nil
> +    data.each_line do |line|
> +      if not msg
> +        case line
> +        when /^author ([^<>]+) <(\S+)> (.+)$/
> +          @persons << fmt_person($1, $2)
> +        when /^$/
> +          msg = true
> +        end

When there's a blank line, flip the switch and start looking in the
commit message.  Why though?  You're worried that the commit message
will contain a line matching /^author ([^<>]+) <(\S+)> (.+)$/?  If so,
why don't you split('\n', 2), look for the author in the $1 and
Whatevered-by in $2?

> +      else
> +        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/

elif?  Can this be more generic to include Whatevered-by?

> +          @persons << fmt_person($2, $3)

Will $2 ever be nil (from fmt_person)?  ie. Why are you checking for
the special case " <\S+?>$"?

> +        end
> +      end
> +    end
> +    @persons.uniq!

So you don't care if the person has appeared twice or thrice in the message.

> +  end
> +
> +end
> +
> +class Commits
> +
> +  def initialize
> +    @items = {}
> +  end

Okay.

> +  def size
> +    @items.size
> +  end

#size is reminiscent of Array#size and Hash#size.

> +  def each(&block)
> +    @items.each(&block)
> +  end

I can see how you iterate over commits from the code below.  However,
using #each like this is confusing, because the reader expects #each
to be invoked on an Enumerable.  So, I have two suggestions:

1. Use block_given? to make sure that #each works even without a block
(just like Enumerator#each).

2. Mixin Enumerable by putting in an 'include Enumerable' after the
class line.  Aside from clarity, you get stuff like #find for free.

> +  def import

>From reading the code below, your calling semantics are: first set
each @items[id] to a new Commit object.  import is meant to invoke
Commit#parse and set @persons there.  Okay.

> +    return if @items.empty?
> +    File.popen(%w[git cat-file --batch], 'r+') do |p|
> +      p.write(@items.keys.join("\n"))
> +      p.close_write

Okay.

> +      p.each do |l|
> +        if l =~ /^(\h{40}) commit (\d+)/

s/l/line/?

> +          id, len = $1, $2
> +          data = p.read($2.to_i)
> +          @items[id].parse(data)
> +        end
> +      end
> +    end
> +  end
> +
> +  def get_blame(source, start, len, from)
> +    return if len == 0
> +    len ||= 1

Please don't use ||=.  It is notorious for causing confusion in
Ruby-land.  Hint: it's not exactly equivalent to either len = len || 1
or len || len = 1.

> +    File.popen(['git', 'blame', '--incremental', '-C',

Still no -CCC?

> +               '-L', '%u,+%u' % [start, len],
> +               '--since', $since, from + '^',
> +               '--', source]) do |p|
> +      p.each do |line|
> +        if line =~ /^(\h{40})/
> +          id = $1

Use $0 and remove the parens: you're matching the whole line.

> +          @items[id] = Commit.new(id)

Okay.

> +        end
> +      end
> +    end
> +  end
> +
> +  def from_patch(file)
> +    from = source = nil
> +    File.open(file) do |f|
> +      f.each do |line|
> +        case line
> +        when /^From (\h+) (.+)$/
> +          from = $1

Okay.

> +        when /^---\s+(\S+)/
> +          source = $1 != '/dev/null' ? $1[2..-1] : nil

Okay.

> +        when /^@@ -(\d+)(?:,(\d+))?/
> +          get_blame(source, $1, $2, from)

Okay.

> +        end
> +      end
> +    end
> +  end
> +
> +end
> +
> +exit 1 if ARGV.size != 1

Okay.

> +commits = Commits.new
> +commits.from_patch(ARGV[0])
> +commits.import

The calling semantics could be better, but it's not a big complaint.

> +count_per_person = Hash.new(0)

Initializing all keys to 0.  Okay.

> +commits.each do |id, commit|

Cute.

> +  commit.persons.each do |person|
> +    count_per_person[person] += 1

Okay.

> +  end
> +end
> +
> +count_per_person.each do |person, count|
> +  percent = count.to_f * 100 / commits.size
> +  next if percent < $min_percent
> +  puts person

Not going to print percentage as well?

Overall, significant improvement over v3 which used all kinds of
unnecessarily complex data structures and convoluted logic.  Looks
like something I'd want to use: not blindly as a cc-cmd, but just to
get a quick idea.  I also wish for depth most times: a working
shortlog -L --follow would be really nice.
