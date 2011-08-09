From: pbegeland <pbegeland@linea.gov.br>
Subject: Re: Cleaning up history with git rebase
Date: Tue, 09 Aug 2011 09:29:16 -0300
Message-ID: <854d27e28ff65cf8f739ccc42b5500f4@linea.gov.br>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
 <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
 <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
 <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
 <7af8ef40e0034e81a63f1d4a53bf082e-mfwitten@gmail.com>
 <1b66c8efe0214915be2c52a5aacd22de-mfwitten@gmail.com>
 <80e62eb56a83a138a79e112e382da4ae@linea.gov.br>
 <b3e1c29767984546a61e2d10fb180188-mfwitten@gmail.com>
 <ad9fe99851b7a4650e739e2e13b6a7c9@linea.gov.br>
 <7b4a0f436505467fa042739da159e0f4-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ricky Egeland <rickyegeland@linea.gov.br>, <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 14:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqlR1-0002Sv-Vn
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 14:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab1HIM3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 08:29:21 -0400
Received: from mx1.linea.gov.br ([200.143.212.2]:53480 "EHLO mx1.linea.gov.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab1HIM3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 08:29:20 -0400
Received: (qmail 14046 invoked from network); 9 Aug 2011 12:29:16 -0000
Received: from unknown (HELO roundcube) (pbegeland@[10.1.1.3])
          (envelope-sender <pbegeland@linea.gov.br>)
          by mx1.linea.gov.br (qmail-ldap-1.03) with SMTP
          for <mfwitten@gmail.com>; 9 Aug 2011 12:29:16 -0000
In-Reply-To: <7b4a0f436505467fa042739da159e0f4-mfwitten@gmail.com>
X-Sender: pbegeland@linea.gov.br
User-Agent: RoundCube Webmail/0.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179031>

 On Sun, 07 Aug 2011 19:13:01 -0000, Michael Witten <mfwitten@gmail.com> 
 wrote:
> On Sat, 06 Aug 2011 23:59:50 -0000, Michael Witten wrote:
>
>>> On Fri, 05 Aug 2011 18:26:27 -0300, Patricia Egeland wrote:
>>>
>>> I'd be greatly appreciated if you are still willing to help.
>>
>> ... my original script is incredibly naive (to the point of
>> being incorrect).
>
> In particular, my use of `cherry-pick' doesn't make any sense
> for all but the most contrived case.
>
>> Fortunately, I've thought a bit more about it, and I have a much
>> better solution in the works, so please hold on just a bit longer
>> while I work out the kinks.
>
> Using `rebase' is not the right solution because it doesn't handle 
> merges
> meaningfully and it also throws out information, especially when it 
> does
> successfully flatten merges (something that my first script attempted
> to emulate, too).
>
> As I began figuring out the necessary bookkeeping required for 
> achieving
> a cleaner history for your case, it occurred to me that 
> `filter-branch'
> does indeed handle a lot of the details already.
>
> What follows is the new script, which I've tested fairly well this 
> time,
> and it shouldn't give you any confusing output either:
>
>   #!/bin/sh
>
>   if b=$(git symbolic-ref -q HEAD); then
>     git branch "${b#refs/heads/}-saved" || exit 1;
>   fi
>
>   workdir= git filter-branch -f --commit-filter '
>
>     if [ $# -eq 1 ]; then
>
>       if [ $(git ls-tree --name-only $1 | wc -l) -eq 0 ]; then
>         echo # Possible abuse of internals
>       else
>         git commit-tree $@
>       fi
>
>     elif [ $# -eq 3 ]; then
>
>       git_commit_non_empty_tree $@
>
>     else
>
>       tree=$1
>       shift
>
>       parents=
>       while [ $# -gt 0 ]; do
>         shift
>         parents="$parents $1"
>         shift
>       done
>
>       parents_independent=
>       for parent in $(git merge-base --independent $parents); do
>         parents_independent="$parents_independent -p $parent"
>       done
>
>       git_commit_non_empty_tree $tree $parents_independent
>
>     fi
>
>   ' HEAD
>
> That `workdir=' bit at the top simply exports the `workdir' variable 
> for
> the duration of the `filter-branch' command, and it is a workaround 
> for
> the following bug:
>
>   Message-ID: <f06dd070abcc485e98c054ec3ee298f9-mfwitten@gmail.com>
>   http://marc.info/?l=git&m=131268922806303&w=2
>
> In order to use this script, save it to a file (e.g. /tmp/s) and 
> then:
>
>   git checkout branch-to-clean
>   sh /tmp/s
>
> That should save the messy history as a branch named 
> `branch-to-clean-saved'
> and also leave the clean history behind in `branch-to-clean'.
>
> Now, you've been doing a lot of work with your subrepos, so please 
> make
> sure that you're running the script on the right branch.


 It worked perfectly, Michael. Like a charm.
 I believe your script can become a great contribution to the git 
 community.

 My merge commit messages reduced from 470 to 155. The history looks 
 very clean and organized.

 Thanks a lot for all the time you spent helping us.

 Best,
 Patricia



>
> Sincerely,
> Michael Witten
>
> I built a test repository as follows (which requires a little manual
> intervention along the way, in that you must save commit messages by
> hand after the automatic conflict resolutions):
>
>   #!/bin/sh
>
>   git init test
>   cd test
>
>   printf A > foo
>   printf A > bar
>   git add .
>   git commit -m A
>   git branch A
>
>   git checkout -b B_foo A
>   printf B > foo
>   git commit -am B_foo
>
>   git checkout -b B_bar A
>   printf B > bar
>   git commit -am B_bar
>
>   git checkout -b B_baz A
>   printf B > baz
>   git add baz
>   git commit -m B_baz
>
>   git checkout -b C A
>   git merge --no-ff B_foo B_bar
>
>   git checkout -b D C
>   printf D > foo
>   printf D > bar
>   git commit -am D
>
>   git checkout -b E_foo_0 D
>   printf 0 > foo
>   git commit -am E_foo_0
>
>   git checkout -b E_foo_1 D
>   printf 1 > foo
>   git commit -am E_foo_1
>
>   git checkout -b F D
>   git merge --no-ff E_foo_0 E_foo_1  # Conflict.
>   printf F > foo                     # Resolve.
>   git commit -a                      # Commit (using the supplied 
> message).
>
>   git checkout -b G_foo_0 F
>   printf 0 > foo
>   git commit -am G_foo_0
>
>   git checkout -b G_foo_1 F
>   printf 1 > foo
>   git commit -am G_foo_1
>
>   git checkout -b G_quux G_foo_1
>   printf G > quux
>   git add quux
>   git commit -m G_quux
>
>   git checkout -b G_foo_2 G_quux
>   printf 2 > foo
>   git commit -am G_foo_2
>
>   git checkout -b H G_foo_0
>   git merge G_foo_2                  # Conflict.
>   printf G > foo                     # Resolve.
>   git commit -a                      # Commit (using the supplied 
> message).
>
>   git checkout -b I H
>   git merge --no-ff B_baz
>
>   git checkout -b J I
>   printf J > foo
>   printf J > bar
>   printf J > baz
>   git commit -am J
>
>   git checkout -b foo-only J
>   git filter-branch -f --index-filter '
>     git rm --cached --ignore-unmatch bar baz quux
>   ' HEAD
>
>   git checkout -b bar-only J
>   git filter-branch -f --index-filter '
>     git rm --cached --ignore-unmatch foo baz quux
>   ' HEAD
>
>   git checkout -b baz-only J
>   git filter-branch -f --index-filter '
>     git rm --cached --ignore-unmatch foo bar quux
>   ' HEAD
>
>   git checkout -b quux-only J
>   git filter-branch -f --index-filter '
>     git rm --cached --ignore-unmatch foo bar baz
>   ' HEAD
>
>   git checkout -b baz-quux-only J
>   git filter-branch -f --index-filter '
>     git rm --cached --ignore-unmatch foo bar
>   ' HEAD
>
> The branches of importance here are:
>
>   foo-only
>   bar-only
>   baz-only
>   quux-only
>   baz-quux-only
>
> Each is a slice of the 'big' branch `J', and each is reminiscent of 
> one
> of your smaller subrepos.
>
> You'll notice that I didn't bother using `--prune-empty' when I 
> created
> the slices, as the new script can handle empty commits better anyway
> (it accounts for merge commits, too). Thus, the result is that the
> history of each slice still has the same topology as 'big' branch 
> `J',
> but many of the commits in that topology don't actually contribute 
> any
> content.
>
> So, at this point, the graph of each of the branches in question all
> look the same in terms of the number of commits and the connections
> between them (the only difference is betweeen commit IDs, etc.). For
> instance, the unclean `baz-quux-only' history looks like this:
>
>   $ git log baz-quux-only --graph --format='%s%ncommit: %H%ntree: 
> %T%n%b%n'
>   * J
>   | commit: 26f3c0a6d026c8957439a52bf2d3e6955f627c82
>   | tree: ffe9a251c0df24b955f2e5ebf3d10592052c985a
>   |
>   |
>   *   Merge branch 'B_baz' into I
>   |\  commit: 9242bb70580a3bf11f20c8a2ab3fd277885739ad
>   | | tree: 155fd83a71d531e1a0413dc4a475af4e72d471c2
>   | |
>   | |
>   | * B_baz
>   | | commit: b95287cda5d2ed5e8af100cd059ac9aef25d4369
>   | | tree: e60c1f8cd2a0eccc2e4527aafa58865c37dc3ba9
>   | |
>   | |
>   * |   Merge branch 'G_foo_2' into H
>   |\ \  commit: 9093055281c6f971b9fbdede06e03bd4824e42ef
>   | | | tree: ff8ecc87699e099733f3145c4bb97466b0a9aec9
>   | | | Conflicts:
>   | | | 	foo
>   | | |
>   | | |
>   | * | G_foo_2
>   | | | commit: e9f3fd76023f0b3f32404b4123c541aa2acfef77
>   | | | tree: ff8ecc87699e099733f3145c4bb97466b0a9aec9
>   | | |
>   | | |
>   | * | G_quux
>   | | | commit: 6eeb3f33f356558fd603afe9dc52331cad279805
>   | | | tree: ff8ecc87699e099733f3145c4bb97466b0a9aec9
>   | | |
>   | | |
>   | * | G_foo_1
>   | | | commit: d33ca0afaa1a844fc84a2e7cba4bdd581a5794d4
>   | | | tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   | | |
>   | | |
>   * | | G_foo_0
>   |/ /  commit: f2d083d0c92f1fca146893dd094daa5b2dfb73c0
>   | |   tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   | |
>   | |
>   | |
>   |  \
>   *-. \   Merge branches 'E_foo_0' and 'E_foo_1' into F
>   |\ \ \  commit: f6b0822ff36b35e6239fffddaa82750d3d9e2832
>   | | | | tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   | | | | Conflicts:
>   | | | | 	foo
>   | | | |
>   | | | |
>   | | * | E_foo_1
>   | |/ /  commit: f1f4dddcd5de8bdf23f700b3267b20ce9f88c58c
>   |/| |   tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   | | |
>   | | |
>   | * | E_foo_0
>   |/ /  commit: dddb96a1b0b3659db3ed0245dc5c08d2d74855aa
>   | |   tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   | |
>   | |
>   * | D
>   | | commit: 9d643ba07d58211211351c9e9266c5a9171965e8
>   | | tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   | |
>   | |
>   | |
>   |  \
>   *-. \   Merge branches 'B_foo' and 'B_bar' into C
>   |\ \ \  commit: ed26df8f1192de9eae864f220dda35bbd53b8516
>   | |_|/  tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   |/| |
>   | | |
>   | | * B_bar
>   | |/  commit: 3202bd87d37ae084bee86158391489fc7c55002a
>   |/|   tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   | |
>   | |
>   | * B_foo
>   |/  commit: 6088f291122686d6f06ab33082e77937d486b354
>   |   tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>   |
>   |
>   * A
>     commit: 104393c27f4ee7a1cbbdae17d21a2f478e8f723f
>     tree: 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>
> As you can see, there are a lot of commits there that are completely
> irrelevant.
>
> Assuming that the new script is stored as /tmp/s, then this history
> can be cleaned up as follows:
>
>   git checkout baz-quux-only
>   sh /tmp/s
>
> This should save the messy history as branch `baz-quux-only-saved' 
> and
> also leave the following clean history behind in branch 
> `baz-quux-only':
>
>   $ git log baz-quux-only --graph --format='%s%ncommit: %H%ntree: 
> %T%n%b%n'
>   * J
>   | commit: f460d134835ece09bab7b3584934930bc5abfb40
>   | tree: ffe9a251c0df24b955f2e5ebf3d10592052c985a
>   |
>   |
>   *   Merge branch 'B_baz' into I
>   |\  commit: 38da9ce07e6859b6cabadcaca1b2eed78c3f8cd5
>   | | tree: 155fd83a71d531e1a0413dc4a475af4e72d471c2
>   | |
>   | |
>   | * B_baz
>   |   commit: bd25181fd0c806a4495400cd13e21007e36c600b
>   |   tree: e60c1f8cd2a0eccc2e4527aafa58865c37dc3ba9
>   |
>   |
>   * G_quux
>     commit: 7c7080def8e2e000e9e9b1e9efc863155b8188e0
>     tree: ff8ecc87699e099733f3145c4bb97466b0a9aec9
>
> Notice how even the root commits have been improved; there is now:
>
>   * a root that creates the `quux' file.
>   * a root that creates the `baz'  file.
>
> and these 2 roots are merged together. There are no empty commits.
>
> Similarly, the unclean history for `foo-only' may be cleaned up as 
> follows:
>
>   git checkout foo-only
>   sh /tmp/s
>
> producing the following history:
>
>   $ git log foo-only --graph --format='%s%ncommit: %H%ntree: 
> %T%n%b%n'
>   * J
>   | commit: 6c88a36c2bba348baea557687601a5337cf978c4
>   | tree: 9e990d3e85287e21abe7b0b06f062fb9b16e769c
>   |
>   |
>   *   Merge branch 'G_foo_2' into H
>   |\  commit: cdb5e89aad7b399bb8c7de5702350205158bdede
>   | | tree: 0f149c5cc454a9d23e00d40819c25f49c90f682a
>   | | Conflicts:
>   | | 	foo
>   | |
>   | |
>   | * G_foo_2
>   | | commit: 861c76fb89846c4100c241e554123befdd074fa0
>   | | tree: cfa452475c8f564b762ce25143cf905568c172a9
>   | |
>   | |
>   | * G_foo_1
>   | | commit: b8a3e5d6230c2312b6675e2b36deaa9310c5bd18
>   | | tree: 0c6433b15dcd449d4d6acf053a18301d96b43fc0
>   | |
>   | |
>   * | G_foo_0
>   |/  commit: 8c0c515f0f9ec5994d4f8e5f244c3e869abb0384
>   |   tree: a39b4d0fdb82ee3da3e01875236754ef983f431b
>   |
>   |
>   *   Merge branches 'E_foo_0' and 'E_foo_1' into F
>   |\  commit: be03f5a201d9fea098f733b9bb1d58d30e89ac9c
>   | | tree: 8d5bb46eff3e15e67f77e2fc9ddb6be755df2b5b
>   | | Conflicts:
>   | | 	foo
>   | |
>   | |
>   | * E_foo_1
>   | | commit: ba04ecb0bac23315b5ef1e68d571487766ab017e
>   | | tree: 0c6433b15dcd449d4d6acf053a18301d96b43fc0
>   | |
>   | |
>   * | E_foo_0
>   |/  commit: 676e381590a316d68b65c2c57d82f06d189e42c7
>   |   tree: a39b4d0fdb82ee3da3e01875236754ef983f431b
>   |
>   |
>   * D
>   | commit: 6ade1fbc6b41577c03bf38bfdb08e5fc8f8581e2
>   | tree: 6a34a4b5b563e07707e3da3e9c39de796b4bf790
>   |
>   |
>   * B_foo
>   | commit: 8dd97d2a76ea2a07741b86064fd44e8da1170a7e
>   | tree: 9712ce0451874e06403b4b60fe662ef2d111d8e5
>   |
>   |
>   * A
>     commit: 7d063cc6bd302f0c5d83bd7de3415397cf45cec8
>     tree: 150d77852b97356b90e6a1cae8b62e85613637a1
>
> As you can see, the first merge commit has been completely flattened,
> the branching histories have been simplified by fast-forwading where
> possible, and non-contributing commits have been pruned.
>
> The rest of the cleaned histories follow:
>
>   $ git log bar-only --graph --format='%s%ncommit: %H%ntree: 
> %T%n%b%n'
>   * J
>   | commit: bc915e51a3619584adbe048a5002a9be26503d1b
>   | tree: e175a92b6e4240caf24b6b8517ab184f5fbc2deb
>   |
>   |
>   * D
>   | commit: 7a5d0cf2761f430e8d2879b02476b1c2882f28d3
>   | tree: a8710e5cbcfd7b411113eb0c8417a82c6214afa8
>   |
>   |
>   * B_bar
>   | commit: 18c5f8e0b0934577d7aa04cb8b3692b295503fe1
>   | tree: b09152c27cc708366ee1d2e920adfc2faf021143
>   |
>   |
>   * A
>     commit: 6ed22455ae04e9e6fcd9a5001dd33703781d5d07
>     tree: 3786d2ba9edc25dddab82eb87e53ebbee57a8dab
>
>
>   $ git log baz-only --graph --format='%s%ncommit: %H%ntree: 
> %T%n%b%n'
>   * J
>   | commit: 1a86f4d0424367e7e75ad45f60127ff4ad0e23dd
>   | tree: 966dd81a7ee77d0b6da290769f22060fed665984
>   |
>   |
>   * B_baz
>     commit: bd25181fd0c806a4495400cd13e21007e36c600b
>     tree: e60c1f8cd2a0eccc2e4527aafa58865c37dc3ba9
>
>
>   $ git log quux-only --graph --format='%s%ncommit: %H%ntree: 
> %T%n%b%n'
>   * G_quux
>     commit: 7c7080def8e2e000e9e9b1e9efc863155b8188e0
>     tree: ff8ecc87699e099733f3145c4bb97466b0a9aec9
>
> As you can see, there are some amazing simplifications here.
